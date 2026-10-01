import Definitions.Def_ChapterConvolutionCalc
import Mathlib


/-!
# The cut-off energy estimate for `−Δ_S + W`

Let `v` be a smooth function on `ℝᵈ` satisfying the pointwise equation

`Δ_S v = G − z v`,  `Re z = 0`,

and let `χ` be a real compactly supported smooth cut-off.  Multiplying the equation by
`χ² v̄`, integrating, and integrating by parts once in each direction of `S` gives

`∫ χ²|∇_S v|² + Re ∫ χ² v̄ G = −2 Re ∑_j ∫ χ (∂_jχ) v̄ ∂_j v`,

and Young's inequality `2ab ≤ a²/2 + 2b²` absorbs the right-hand side:

`Re ∫ χ² v̄ G ≤ 2 ∑_{j ∈ S} ∫ |∂_jχ|² |v|²`.

That is `energy_bound`, the analytic heart of the Kato-type theorem of
`BookProof/ChapterDegKatoEsa.lean`: no ellipticity in the directions outside `S` is used,
and no regularity of `G` beyond continuity.
-/

namespace BookProof.DegEnergy

open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section

variable {d : ℕ}

/-! ## 1. Calculus preliminaries -/









/-! ## 2. The energy estimate -/

variable (S : Finset (Fin d))

/-- The complexified cut-off. -/
def cx (χ : Vd d → ℝ) : Vd d → ℂ := fun y => ((χ y : ℝ) : ℂ)
















end

end BookProof.DegEnergy
