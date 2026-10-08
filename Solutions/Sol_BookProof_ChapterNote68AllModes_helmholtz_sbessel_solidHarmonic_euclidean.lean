-- Generated from ChapterNote68AllModes.lean — solution of BookProof.ChapterNote68AllModes.helmholtz_sbessel_solidHarmonic_euclidean
import Mathlib
import Definitions.Def_ChapterNote68AllModes
import Theorems.Thm_BookProof_ChapterNote68AllModes_helmholtz_sbessel_solidHarmonic
import Theorems.Thm_BookProof_ChapterNote68AllModes_inner_stdVec
import Theorems.Thm_BookProof_ChapterNote68AllModes_norm_stdVec
import Theorems.Thm_BookProof_ChapterNote68AllModes_finrank_euclidean_three
open BookProof.ChapterNote68AllModes




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {l μ : ℕ} (hμ : μ ≤ l)
    {x : EuclideanSpace ℝ (Fin 3)} {p : ℝ} (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : EuclideanSpace ℝ (Fin 3) =>
        (sbessel l (p * ‖y‖) / ‖y‖ ^ l) * solidHarmonic (stdVec 0) (stdVec 1) (stdVec 2) l μ y) x
      = p ^ 2 * ((sbessel l (p * ‖x‖) / ‖x‖ ^ l)
          * solidHarmonic (stdVec 0) (stdVec 1) (stdVec 2) l μ x) :=
  helmholtz_sbessel_solidHarmonic (norm_stdVec 0) (norm_stdVec 1) (norm_stdVec 2)
      (inner_stdVec (by decide)) (inner_stdVec (by decide)) (inner_stdVec (by decide))
      finrank_euclidean_three hμ hp hx
