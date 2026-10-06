-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.hermOfMom_nullMom
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution : hermOfMom nullMom = !![(2 : ℂ), 0; 0, 0] := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [hermOfMom, nullMom, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
