/* This function is only required to generate a random string, that is used
as a personal ID for every peer, since it is not possible at the moment to
get the own peer ID from the beaker browser.
*/
function random(length: number = 16) {
  // Declare all characters
  let chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'

  // Pick characters randomly
  let str = ''
  for (let i = 0; i < length; i++) {
    str += chars.charAt(Math.floor(Math.random() * chars.length))
  }

  return str
}

export class Sync {
  protected send: Lia.Send
  protected room?: string
  protected course?: string
  protected username?: string
  protected password?: string

  protected token: string

  constructor(send: Lia.Send) {
    this.send = send

    let token = window.localStorage.getItem('lia-token')

    if (!token) {
      token = random()
      window.localStorage.setItem('lia-token', token)
    }

    this.token = token
  }

  /* to have a valid connection 3 things are required:
  
  - a sender to connect to liascript
  - a matching course-url
  - a matching room-id

  the remaining 2 things are optional
  */
  connect(data: {
    course: string
    room: string
    username: string
    password?: string
  }) {
    this.room = data.room
    this.course = data.course

    this.username = data.username
    this.password = data.password
  }

  disconnect() {}

  uniqueID() {
    if (this.course && this.room) {
      return JSON.stringify({
        course: this.course,
        room: this.room,
      })
    }

    console.warn('Sync: no uniqueID')
    return ''
  }

  publish(event: any) {}

  subscribe(topic: string) {}
}
