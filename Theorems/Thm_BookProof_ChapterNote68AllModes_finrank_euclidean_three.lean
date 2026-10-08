-- Generated from ChapterNote68AllModes.lean — theorem BookProof.ChapterNote68AllModes.finrank_euclidean_three
import Definitions.Def_ChapterSphericalBessel
import Definitions.Def_ChapterBesselHarmonic
import Definitions.Def_ChapterSolidHarmonic
import Mathlib
import Definitions.Def_ChapterNote68AllModes
open BookProof.ChapterNote68AllModes



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]


theorem BookProof.ChapterNote68AllModes.finrank_euclidean_three : Module.finrank ℝ (EuclideanSpace ℝ (Fin 3)) = 3 := by sorry
