-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.castR_transpose
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin 4) (Fin 4) ℤ) : castR (Aᵀ) = (castR A)ᵀ := by

  ext i j; simp [castR, RingHom.mapMatrix_apply, Matrix.transpose_apply, Matrix.map_apply]
