import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvLp_mem_core

import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The Gauss–polynomial core approximates the compactly supported core in the graph norm

`BookProof/ChapterQgOneParticleCcEsa.lean` transports essential self-adjointness *from* the
Gauss–polynomial core *to* the compactly supported smooth core, by cutting a Gauss
polynomial off outside a large ball.  The Kato theorem of `BookProof/ChapterDegKatoEsa.lean`
runs the other way: it is proved on the compactly supported core, and what is needed is the
opposite approximation — every compactly supported smooth `ψ` must be approximated, in the
graph norm of `−Δ_S + W`, by Gauss polynomials.

That is supplied here by the **Hermite expansion**.  Let `ψ_α` be the product Hermite basis
of `BookProof.HermiteProductBasis`, `c_α = ⟪ψ_α, ψ⟫`, and let `Λ = ∑_i a_i† a_i` be the
number operator, for which `Λ ψ_α = |α| ψ_α`.  Then

* integrating by parts twice against the (compactly supported!) `ψ` gives
  `|α|² c_α = ⟪ψ_α, Λ²_cl ψ⟫`, so Bessel's inequality bounds `∑_α (|α|+1)⁴ |c_α|²` by a
  multiple of `‖ψ‖² + ‖Λ_cl ψ‖² + ‖Λ²_cl ψ‖²`, which is finite;
* every operator occurring in `−Δ_S + W` with `W` a polynomial of degree `≤ k` is a finite
  combination of products of at most `max (k, 2)` ladder operators, and a product of `n`
  ladder operators maps `ψ_α` to a multiple, of size at most `(|α| + n)^{n/2}`, of a single
  basis vector; hence `‖(−Δ_S + W) v‖ ≤ C ∑_α (|α| + n)^n |c_α|²` on the core.

Together these make the Hermite truncations of `ψ` a Cauchy sequence in the graph norm; the
limit is `ψ` in `L²` and `(−Δ_S + W)ψ` in the graph coordinate, because the core is dense
and the operator is symmetric.
-/

namespace BookProof.HermiteGraphApprox

open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

/-! ## 1. The operator on compactly supported smooth functions -/

/-- `−Δ_S + W` acting on functions. -/
def Lfun (S : Finset (Fin d)) (W : Vd d → ℝ) (g : Vd d → ℂ) : Vd d → ℂ :=
  fun x => -lapCS S g x + ((W x : ℝ) : ℂ) * g x









/-! ## 2. Integration by parts between the two cores -/









/-! ## 3. The pairing in `L²` -/





/-! ## 4. The number operator -/



/-- The potential of `Λ + 1 = −Δ + ‖x‖²/4 − d/2 + 1`, `Λ = ∑ᵢ aᵢ†aᵢ` the number operator. -/
def numPoly (d : ℕ) : MvPolynomial (Fin d) ℂ :=
  (∑ i, C (((1 / 4 : ℝ)) : ℂ) * (X i * X i)) + C (((1 - (d : ℝ) / 2 : ℝ)) : ℂ)











/-! ## 5. The Hermite coefficients of a compactly supported smooth function decay fast -/



/-- `Λ + 1` acting on functions. -/
def numFun (d : ℕ) : (Vd d → ℂ) → (Vd d → ℂ) := Lfun Finset.univ (polyW (numPoly d))











/-! ## 6. The operator on the Gauss–polynomial core -/









/-! ## 7. Hermite truncations -/

/-- The Hermite truncation `∑_{α ∈ F} c_α(v) ψ_α`. -/
def htrunc (v : L2d d) (F : Finset (Fin d →₀ ℕ)) : L2d d := ∑ a ∈ F, coef a v • hermiteMvLp a

theorem htrunc_mem_core (v : L2d d) (F : Finset (Fin d →₀ ℕ)) :
    htrunc v F ∈ polyGaussCore (d := d) :=
  Submodule.sum_mem _ fun a _ => Submodule.smul_mem _ _ (hermiteMvLp_mem_core a)









/-! ## 8. The graph approximation -/

/-- The Hermite truncation, as an element of the Gauss–polynomial core. -/
def truncCore (v : L2d d) (F : Finset (Fin d →₀ ℕ)) : polyGaussCore (d := d) :=
  ⟨htrunc v F, htrunc_mem_core v F⟩











end

end BookProof.HermiteGraphApprox
