-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.castR_trace
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin 4) (Fin 4) ℤ) : (castR A).trace = ((A.trace : ℤ) : ℝ) := by

  simp [castR, Matrix.trace, Matrix.diag, RingHom.mapMatrix_apply, Matrix.map_apply]
