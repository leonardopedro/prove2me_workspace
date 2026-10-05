-- Generated from ChapterNote68AllModes.lean — solution of BookProof.ChapterNote68AllModes.finrank_euclidean_three
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
theorem solution : Module.finrank ℝ (EuclideanSpace ℝ (Fin 3)) = 3 := by

  simp
