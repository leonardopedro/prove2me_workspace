-- Generated from ChapterNote68AllModes.lean — solution of BookProof.ChapterNote68AllModes.inner_stdVec
import Mathlib
import Definitions.Def_ChapterNote68AllModes
open BookProof.ChapterNote68AllModes




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {i j : Fin 3} (h : i ≠ j) : ⟪stdVec i, stdVec j⟫_ℝ = 0 := by

  rw [stdVec, stdVec, EuclideanSpace.inner_single_left, EuclideanSpace.single_apply]
  simp [h]
