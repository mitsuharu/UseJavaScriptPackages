import mean from "just-mean"
import random from "just-random"
import { transform } from "receiptline"

export class Bridge {

    static mean(array) {
        return mean(array)
    }

    static random(array) {
        return random(array)
    }

    static transformCommand(doc) {
        const printer = {
            cpl: 42,
            encoding: 'multilingual',
            upsideDown: false,
            gamma: 1.8,
            command: 'escpos'
        }
        const command = transform(doc, printer)
        return command
    }

    static transformSvg(doc) {
        const display = {
            cpl: 42,
            encoding: 'multilingual'
        }
        const svg = transform(doc, display)
        return svg
    }
}