import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterMollifierL2
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStrichartzWave
import Mathlib


/-!
# Kato's theorem for `−Δ_S + W`, `W ≥ 1`, on the compactly supported smooth core

This module proves the analytic input that the Faris–Lavine criterion cannot supply: a
Schrödinger operator with an arbitrary smooth potential bounded below, and with a kinetic
term that differentiates only a subset `S` of the coordinates, is **essentially
self-adjoint on the compactly supported smooth core of `L²(ℝᵈ)`**.

## The argument

Let `w ∈ L²` be a deficiency vector at a purely imaginary `z`:
`⟪(−Δ_S + W)φ, w⟫ = z ⟪φ, w⟫` for every `φ ∈ C_c^∞(ℝᵈ)`.  No elliptic regularity is used.
Instead one *mollifies*: for a smooth compactly supported mollifier `ρ_ε` the function
`w_ε = w ∗ ρ_ε` is smooth, and testing the deficiency equation against the (compactly
supported, smooth) translate `y ↦ ρ_ε(x − y)` gives the *pointwise* identity

`Δ_S w_ε = ((W − z̄) w) ∗ ρ_ε`.

Testing this identity against `χ_R² w̄_ε`, with `χ_R` a cut-off equal to `1` on the ball of
radius `R`, and integrating by parts once in each direction of `S`, gives the energy
inequality

`∫ χ_R² |∇_S w_ε|² + Re ∫ χ_R² w̄_ε ((W − z̄)w) ∗ ρ_ε = −2 Re ∫ χ_R w̄_ε ∇χ_R · ∇w_ε`,

whose right-hand side is absorbed by Young's inequality into
`½ ∫ χ_R²|∇_S w_ε|² + 2∫|∇_Sχ_R|²|w_ε|² ≤ ½ ∫ χ_R²|∇_S w_ε|² + (2C²/R²)‖w‖²`.
Letting `ε → 0` at fixed `R` (all the integrands converge in `L¹` of the compact set
`supp χ_R`) and using `Re z = 0` leaves

`∫ χ_R² W |w|² ≤ (2C²/R²) ‖w‖²`,

and `W ≥ 1` then forces `∫_{‖x‖ ≤ R} |w|² ≤ (2C²/R²)‖w‖²`.  Letting `R → ∞` gives `w = 0`.
-/

namespace BookProof.DegKatoEsa

open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}

/-! ## 1. The deficiency equation in test-function form -/

/-- A compactly supported smooth function, as an element of the compactly supported core. -/
def ccOf {φ : Vd d → ℂ} (hφ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) φ)
    (hφc : HasCompactSupport φ) : ccDomain (Vd d) :=
  ccEquiv (Vd d) ⟨hφc.toSchwartzMap hφ, hφc⟩





/-! ## 2. The mollified deficiency vector solves the equation pointwise -/



/-! ## 3. A mollifier sequence -/

/-- The bump of radius `1/(n+1)` underlying the `n`-th mollifier. -/
def molBump (d : ℕ) (n : ℕ) : ContDiffBump (0 : Vd d) where
  rIn := 1 / (2 * ((n : ℝ) + 1))
  rOut := 1 / ((n : ℝ) + 1)
  rIn_pos := by positivity
  rIn_lt_rOut := by
    have h : (0 : ℝ) < (n : ℝ) + 1 := by positivity
    rw [div_lt_div_iff₀ (by positivity) h]
    nlinarith

/-- The `n`-th mollifier: a smooth probability density supported in the ball of radius
`1/(n+1)`. -/
def mol (d : ℕ) (n : ℕ) : Vd d → ℝ := (molBump d n).normed volume

















/-! ## 4. `L²` bookkeeping -/









/-! ## 5. The cut-off estimate for a deficiency vector -/



/-! ## 6. The deficiency spaces are trivial -/







end

end BookProof.DegKatoEsa
