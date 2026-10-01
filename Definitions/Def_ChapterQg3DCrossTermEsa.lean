import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Mathlib


/-!
# The 3D gravity Hamiltonian **with the Weyl-ordered cross terms**: essential
self-adjointness on the Gauss–polynomial core (QG-3.2(b), flat-density form)

The Hamiltonian density of `book.tex` (the 3-dimensional form, around line 8190) is

`ℋ = (1/(16e)) 𝒮^{ab}𝒮_{ab} − (1/(24e)) 𝒫² + ½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a − e(…)`,

where `𝒮^{ab} = p^{ab} + p^{ba} − ⅔ η^{ab} 𝒫`, `𝒫 = η_{ab} p^{ab}`, the `E_{ab}` are the
derivative coordinates and the bracket `(…)` is quadratic in the torsion, i.e. in the
derivative coordinates.  `BookProof.Qg3DGaugeEsa.qg3D_essentiallySelfAdjointOn_core` proved
ESA of the kinetic-plus-torsion part `½ Σ κ_j π_j² + ½ Σ T_m²` only; the cross terms
`½ 𝒮·E + ⅓ 𝒫·E` (momentum × coordinate, which must be Weyl ordered) and the bracket were
not part of that operator.  This module adds them.

## What is proved

* `qgCouplingPoly`, `qgCouplingOp` — a general Weyl-ordered quadratic coupling
  `Σ_{i,j} (Q'ᵢⱼ xᵢxⱼ + Cᵢⱼ ½(xᵢπⱼ + πⱼxᵢ)) + Σᵢ (bᵢxᵢ + b'ᵢπᵢ)` on the core, for arbitrary real
  data (no sign, symmetry or smallness hypothesis).
* `qgWithCoupling_esa` — **for every real signature `κ` and every such coupling**, the operator
  `½ Σ κ_j π_j² + ½ Σ T_m² + coupling` is essentially self-adjoint on the Gauss–polynomial
  core.  The proof is an identification with the general real quadratic Hamiltonian of
  `BookProof.FullQuadratic` (`fqPoly_add_coupling`), not a perturbation argument.
* The book's cross terms, concretely: `pVec`, `eVec` (the coefficient vectors of `p^{ab}` and
  `E_{ab}` in the `84` canonical coordinates), `calPVec`, `calSVec`, `eTrVec`, and the
  cross-coefficient matrix `bookCrossMat` of `½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a`.
* `bookCrossMat_eq_sym` — **the trace parts cancel**: `½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a
  = ½ Σ_{a,b} (p^{ab} + p^{ba}) E_{ab}`, because `½ · (−⅔ η^{ab} 𝒫) E_{ab} = −⅓ 𝒫 E_a{}^a`.
* `qg3DCrossHamiltonian`, **`qg3DCross_esa`** — the physical (hyperbolic) signature `qgKappa`,
  the torsion potential, the book's Weyl-ordered cross terms `½ 𝒮·E + ⅓ 𝒫·E`, and an
  arbitrary real quadratic bracket `Q'`: essentially self-adjoint on the core.
  `qg3DCross_stone_flow` is the resulting unitary group.
* `qg3DCross_dGamma_esa` — its enclosure `dΓ(h)` (creation left / annihilation right) is
  essentially self-adjoint on the finite-particle domain; `qg3DCross_dGammaOp_esa` — the same in
  the occupation-number spelling on the finite-occupation core (product Hermite basis).

## Honest boundary

* **Flat density.**  The density `e = det e` is held at its flat value `e = 1` (so `y = √e = 1`
  and the densitized and undensitized momenta agree; the inverse tetrads `χ` are `δ`).  At
  that value every term of the book density is quadratic in the canonical pair, which is what
  makes the identification with a quadratic Hamiltonian possible.  The genuine `e`-dependence —
  the `1/e` of the kinetic term, the factor `y` in `𝒮 = y 𝒮̃`, and the degree-four polynomial
  `e` multiplying the bracket — is **not** covered.
* **Index conventions.**  `p^{ab}` is taken as `η^{bb} π_{e_b{}^a}` and `E_{ab}` as the
  derivative coordinate `∂_0 e_b{}^a` (the time-like `v^μ = δ^μ_0` of the non-ADM reduction).
  Since `qgWithCoupling_esa` holds for **every** real cross-coefficient matrix, a different
  convention changes `bookCrossMat` but not the conclusion.
* **The bracket** `(…)` is not written out index by index; it enters as an arbitrary real
  matrix `Q'` (at `e = 1` it is a real quadratic form in the derivative coordinates).
* No gap, no spectrum, no continuum limit is claimed.
-/

namespace BookProof.Qg3DCrossTermEsa

open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

/-! ## 1. A general Weyl-ordered quadratic coupling -/

/-- The Weyl-ordered quadratic coupling
`Σ_{i,j} (Q'ᵢⱼ xᵢxⱼ + Cᵢⱼ ½(xᵢπⱼ + πⱼxᵢ)) + Σᵢ (bᵢxᵢ + b'ᵢπᵢ)` at polynomial level. -/
def qgCouplingPoly (Q' C : Fin 84 → Fin 84 → ℝ) (b b' : Fin 84 → ℝ) :
    MvPolynomial (Fin 84) ℂ →ₗ[ℂ] MvPolynomial (Fin 84) ℂ :=
  (∑ i, ∑ j, (((Q' i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j)
      + ((C i j : ℝ) : ℂ) • weylProd (mulXPoly i) (momPoly j))) + foPoly b b'

/-- The Weyl-ordered quadratic coupling as an operator from the core into `L²(ℝ⁸⁴)`. -/
def qgCouplingOp (Q' C : Fin 84 → Fin 84 → ℝ) (b b' : Fin 84 → ℝ) :
    (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  (polyGaussCore (d := 84)).subtype ∘ₗ coreOp (qgCouplingPoly Q' C b b')



/-- The kinetic-plus-torsion operator with an arbitrary Weyl-ordered quadratic coupling. -/
def qgWithCoupling (kappa : Fin 84 → ℝ) (Q' C : Fin 84 → Fin 84 → ℝ) (b b' : Fin 84 → ℝ) :
    (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84)) + qgCouplingOp Q' C b b'





/-! ## 2. The book's cross terms `½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a` -/

/-- The Minkowski metric `η = diag(−1, 1, 1, 1)` (its own inverse). -/
def qgEta (a : Fin 4) : ℝ := if a = 0 then -1 else 1

/-- The coefficient vector of the polymomentum `p^{ab} = η^{bb} π_{e_b{}^a}` in the `84`
momenta (flat background). -/
def pVec (a b : Fin 4) (j : Fin 84) : ℝ := if j = idxE b a then qgEta b else 0

/-- The coefficient vector of the derivative coordinate `E_{ab} = ∂_0 e_b{}^a`. -/
def eVec (a b : Fin 4) (i : Fin 84) : ℝ := if i = idxDE 0 b a then 1 else 0

/-- `𝒫 = η_{ab} p^{ab}` (η diagonal). -/
def calPVec (j : Fin 84) : ℝ := ∑ a : Fin 4, qgEta a * pVec a a j

/-- `𝒮^{ab} = p^{ab} + p^{ba} − ⅔ η^{ab} 𝒫`. -/
def calSVec (a b : Fin 4) (j : Fin 84) : ℝ :=
  pVec a b j + pVec b a j - 2 / 3 * (if a = b then qgEta a else 0) * calPVec j

/-- `E_a{}^a = η^{ab} E_{ab}`. -/
def eTrVec (i : Fin 84) : ℝ := ∑ a : Fin 4, qgEta a * eVec a a i

/-- **The cross-coefficient matrix of `½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a`**: the coefficient of the
Weyl-ordered product `½(xᵢπⱼ + πⱼxᵢ)`. -/
def bookCrossMat (i j : Fin 84) : ℝ :=
  ∑ a : Fin 4, ∑ b : Fin 4, (1 / 2) * calSVec a b j * eVec a b i + 1 / 3 * calPVec j * eTrVec i





/-- **The 3D gravity Hamiltonian with the book's cross terms**: hyperbolic signature
`qgKappa`, torsion potential, Weyl-ordered `½ 𝒮·E + ⅓ 𝒫·E`, and a real quadratic bracket
`Q'` (flat density `e = 1`). -/
def qg3DCrossHamiltonian (Q' : Fin 84 → Fin 84 → ℝ) :
    (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  qg3DHamiltonian (coreRepPoly 84) + qgCouplingOp Q' bookCrossMat 0 0







/-! ## 3. Second quantization -/







end

end BookProof.Qg3DCrossTermEsa
