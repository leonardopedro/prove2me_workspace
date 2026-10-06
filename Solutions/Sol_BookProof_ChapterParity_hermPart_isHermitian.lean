-- Generated from ChapterParity.lean — solution of BookProof.ChapterParity.hermPart_isHermitian
import Mathlib
import Definitions.Def_ChapterParity
open BookProof.ChapterParity



open Matrix
open scoped ComplexConjugate

variable {n : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (X : Matrix n n ℂ) : (hermPart X).IsHermitian := by

  unfold Matrix.IsHermitian hermPart
  rw [conjTranspose_smul, conjTranspose_add, conjTranspose_conjTranspose]
  simp [add_comm]
