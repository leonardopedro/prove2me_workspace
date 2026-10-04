import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Mathlib


/-!
# Hermite–Sobolev weights and the ladder order of polynomial differential operators

Let `ψ_α` be the product Hermite basis of `L²(ℝᵈ)` (`BookProof.HermiteProductBasis`) and
write `c_α(v) = ⟪ψ_α, v⟫` for the Hermite coefficients of `v`.  For `m : ℕ` put

`‖v‖²_m = ∑_α (|α| + 1)^m |c_α(v)|²  ∈ [0, ∞]`

(`hn m v`, an extended non-negative real, so no summability bookkeeping is needed).  A linear
map `T` of the polynomial ring has **ladder order** `n` (`LadderOrd T n`) if, on the
Gauss–polynomial core, `‖T v‖²_m ≤ C_m ‖v‖²_{m+n}` for every `m`.

* the ladder operators `aᵢ = annPoly i` and `aᵢ† = crePoly i` have ladder order `1`
  (`ladderOrd_annPoly`, `ladderOrd_crePoly`) — this is where the Hermite structure enters,
  through the adjoint relations `⟪q, aᵢ p⟫ = ⟪aᵢ† q, p⟫` (`inner_pgLp_annPoly`) and the
  action of `aᵢ†`, `aᵢ` on the basis;
* ladder order is stable under sums, scalar multiples and compositions (orders add);
* consequently every operator `−Δ_S + W` with a polynomial potential `W` has *some* finite
  ladder order (`exists_ladderOrd_hamPolyL`), and hence, by Parseval
  (`hn_zero_eq`), `‖(−Δ_S + W) v‖² ≤ C ‖v‖²_n` on the core (`norm_sq_le_hn`).
-/

namespace BookProof.HermiteLadder

open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

/-! ## 1. Hermite coefficients and the weighted norms -/

/-- The Hermite coefficient `c_α(v) = ⟪ψ_α, v⟫`. -/
def coef (a : Fin d →₀ ℕ) (v : L2d d) : ℂ := inner ℂ (hermiteMvLp a) v









/-- The weight `(|α| + 1)^m`. -/
def wt (m : ℕ) (a : Fin d →₀ ℕ) : ℝ≥0∞ := ((a.degree + 1 : ℕ) : ℝ≥0∞) ^ m





/-- The Hermite–Sobolev norm `‖v‖²_m = ∑_α (|α| + 1)^m |c_α(v)|²`. -/
def hn (m : ℕ) (v : L2d d) : ℝ≥0∞ := ∑' a, wt m a * ‖coef a v‖ₑ ^ 2











/-! ## 2. Ladder order -/

/-- `T` has **ladder order** `n`: `‖T v‖²_m ≤ C_m ‖v‖²_{m+n}` on the core, for every `m`. -/
def LadderOrd (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) (n : ℕ) : Prop :=
  ∀ m : ℕ, ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ p, hn m (pgLp (T p)) ≤ C * hn (m + n) (pgLp p)

























/-! ## 3. The ladder operators -/

























/-! ## 4. Polynomial differential operators have finite ladder order -/

/-- Multiplication by a polynomial, as a linear map. -/
def mulL (q : MvPolynomial (Fin d) ℂ) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  LinearMap.mulLeft ℂ q

@[simp] theorem mulL_apply (q p : MvPolynomial (Fin d) ℂ) : mulL q p = q * p := rfl







/-- The twisted derivative `coreD j`, as a linear map. -/
def coreDL (j : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun := coreD j
  map_add' := coreD_add j
  map_smul' := coreD_smul j







/-- The polynomial realization `p ↦ kinPolyS S p + q p` of `−Δ_S + W`, as a linear map. -/
def hamPolyL (S : Finset (Fin d)) (q : MvPolynomial (Fin d) ℂ) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := kinPolyS S p + q * p
  map_add' p r := by
    rw [kinPolyS_add]
    ring
  map_smul' c p := by
    rw [kinPolyS_smul, RingHom.id_apply, smul_add, smul_eq_C_mul, smul_eq_C_mul, smul_eq_C_mul]
    ring







/-! ## 5. Parseval -/







end

end BookProof.HermiteLadder
