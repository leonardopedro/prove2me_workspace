-- Generated from ChapterA1h.lean — solution of BookProof.ChapterA.HasQuaternionicRImaginary.hasCommutingRImaginary
import Mathlib
import Definitions.Def_ChapterA1h
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℝ W}
    (h : HasQuaternionicRImaginary M) : HasCommutingRImaginary M := by

  obtain ⟨J, _, hJ, _, _⟩ := h
  exact ⟨J, hJ⟩
