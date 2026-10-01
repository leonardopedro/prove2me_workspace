import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib


/-!
# Mollification as a convolution: smoothness and derivatives

The Kato-type theorem of `BookProof/ChapterDegKatoEsa.lean` mollifies an `L²` deficiency
vector.  This module records the two calculus facts that the mollification needs:

* `contDiff_cnv` — the convolution of a locally integrable function with a compactly
  supported smooth function is smooth;
* `dcoord_cnv`, `lapCS_cnv` — every derivative falls on the smooth factor.

The convolution is written `cnv u ρ x = ∫ u y * ρ (x − y)`, i.e. Mathlib's
`convolution u ρ (ContinuousLinearMap.mul ℝ ℂ) volume`, so that `cnv u ρ x` is literally the
pairing of `u` with the test function `y ↦ ρ (x − y)`.
-/

namespace BookProof.ConvolutionCalc

open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

/-- The convolution `cnv u ρ x = ∫ u y · ρ (x − y)`: the pairing of `u` with the translated
test function `y ↦ ρ (x − y)`. -/
def cnv (u ρ : Vd d → ℂ) : Vd d → ℂ :=
  convolution u ρ (ContinuousLinearMap.mul ℝ ℂ) volume

















/-! ## Reflected test functions -/





end

end BookProof.ConvolutionCalc
