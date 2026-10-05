-- Generated from ChapterNote68AllModes.lean — theorem BookProof.ChapterNote68AllModes.solidHarmonic_spherical_euclidean
import Definitions.Def_ChapterSphericalBessel
import Definitions.Def_ChapterBesselHarmonic
import Definitions.Def_ChapterSolidHarmonic
import Mathlib
import Definitions.Def_ChapterNote68AllModes
open BookProof.ChapterNote68AllModes

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace


theorem BookProof.ChapterNote68AllModes.solidHarmonic_spherical_euclidean {l μ : ℕ} (hμ : μ ≤ l) {r : ℝ} (hr : 0 < r) {θ : ℝ}
    (hθ : 0 ≤ Real.sin θ) (φ : ℝ) :
    solidHarmonic (stdVec 0) (stdVec 1) (stdVec 2) l μ
        (spherePt (stdVec 0) (stdVec 1) (stdVec 2) r θ φ)
      = r ^ l * assocLegendre l μ (Real.cos θ) * Real.cos (μ * φ) := by sorry
