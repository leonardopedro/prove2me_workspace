-- Generated from ChapterNote68AllModes.lean — theorem BookProof.ChapterNote68AllModes.helmholtz_sbessel_solidHarmonic_euclidean
import Definitions.Def_ChapterBesselHarmonic
import Definitions.Def_ChapterSolidHarmonic
import Mathlib
import Definitions.Def_ChapterNote68AllModes
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterNote68AllModes

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace


theorem BookProof.ChapterNote68AllModes.helmholtz_sbessel_solidHarmonic_euclidean {l μ : ℕ} (hμ : μ ≤ l)
    {x : EuclideanSpace ℝ (Fin 3)} {p : ℝ} (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : EuclideanSpace ℝ (Fin 3) =>
        (sbessel l (p * ‖y‖) / ‖y‖ ^ l) * solidHarmonic (stdVec 0) (stdVec 1) (stdVec 2) l μ y) x
      = p ^ 2 * ((sbessel l (p * ‖x‖) / ‖x‖ ^ l)
          * solidHarmonic (stdVec 0) (stdVec 1) (stdVec 2) l μ x) := by sorry
