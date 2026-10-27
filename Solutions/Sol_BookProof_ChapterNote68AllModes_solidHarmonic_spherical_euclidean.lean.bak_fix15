-- Generated from ChapterNote68AllModes.lean — solution of BookProof.ChapterNote68AllModes.solidHarmonic_spherical_euclidean
import Mathlib
import Definitions.Def_ChapterNote68AllModes
import Theorems.Thm_BookProof_ChapterNote68AllModes_inner_stdVec
import Theorems.Thm_BookProof_ChapterNote68AllModes_norm_stdVec
import Theorems.Thm_BookProof_ChapterSolidHarmonic_solidHarmonic_spherical
open BookProof.ChapterNote68AllModes




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {l μ : ℕ} (hμ : μ ≤ l) {r : ℝ} (hr : 0 < r) {θ : ℝ}
    (hθ : 0 ≤ Real.sin θ) (φ : ℝ) :
    solidHarmonic (stdVec 0) (stdVec 1) (stdVec 2) l μ
        (spherePt (stdVec 0) (stdVec 1) (stdVec 2) r θ φ)
      = r ^ l * assocLegendre l μ (Real.cos θ) * Real.cos (μ * φ) :=
  solidHarmonic_spherical (norm_stdVec 0) (norm_stdVec 1) (norm_stdVec 2)
      (inner_stdVec (by decide)) (inner_stdVec (by decide)) (inner_stdVec (by decide)) hμ hr hθ φ
