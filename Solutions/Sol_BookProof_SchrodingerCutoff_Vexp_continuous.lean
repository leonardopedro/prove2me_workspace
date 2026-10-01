-- Generated from ChapterSchrodingerCutoffEsa.lean — solution of BookProof.SchrodingerCutoff.Vexp_continuous
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff




open MeasureTheory Filter Complex

set_option maxHeartbeats 1000000 in
 := fun x => Real.exp x + Real.exp (-x)

t := heorem Vexp_continuous : Cont
