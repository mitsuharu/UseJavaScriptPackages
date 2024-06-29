import mean from "just-mean"
import random from "just-random"
import { Printer, transform } from "receiptline"

export class Bridge {

    static mean(array: number[]) {
        return mean(array)
    }

    static random(array: number[]) {
        return random(array)
    }

    static transformCommand(doc: string) {
        const printer: Printer = {
            cpl: 42,
            encoding: 'multilingual',
            upsideDown: false,
            gamma: 1.8,
            command: 'escpos'
        }
        const command = transform(doc, printer)
        return command
    }

    static transformSvg(doc: string) {
        const display: Printer = {
            cpl: 42,
            encoding: 'multilingual'
        }
        const svg = transform(doc, display)
        return svg
    }
}