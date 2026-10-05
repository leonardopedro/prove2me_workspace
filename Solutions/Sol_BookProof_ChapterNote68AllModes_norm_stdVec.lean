-- Generated from ChapterNote68AllModes.lean — solution of BookProof.ChapterNote68AllModes.norm_stdVec
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
theorem solution (i : Fin 3) : ‖stdVec i‖ = 1 := by

  rw [stdVec, EuclideanSpace.norm_single]
  simp
