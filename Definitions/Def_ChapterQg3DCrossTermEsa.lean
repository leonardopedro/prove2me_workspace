import Theorems.Thm_BookProof_FullQuadratic_fqOp_essentiallySelfAdjoint

import Theorems.Thm_BookProof_FullQuadratic_fqOp_stone_flow

import Theorems.Thm_BookProof_FullQuadratic_fqOp_symmetric

import Theorems.Thm_BookProof_HermiteRelative_coreOp_add

import Theorems.Thm_BookProof_QuadFockEsa_dGamma_fqPoly_essentiallySelfAdjointOn_core

import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterYangMillsHermite
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

/-- The coupling is absorbed into the general quadratic Hamiltonian. -/
theorem fqPoly_add_coupling (P Q Q' C : Fin 84 → Fin 84 → ℝ) (b b' : Fin 84 → ℝ) :
    fqPoly P Q 0 0 0 + qgCouplingPoly Q' C b b' = fqPoly P (Q + Q') C b b' := by
  have hfo : foPoly (d := 84) 0 0 = 0 := by
    simp only [foPoly, Pi.zero_apply, Complex.ofReal_zero, zero_smul, add_zero,
      Finset.sum_const_zero]
  simp only [fqPoly, qgCouplingPoly, fqQuadPoly, hfo, add_zero, Pi.add_apply, Pi.zero_apply,
    Complex.ofReal_zero, zero_smul, Complex.ofReal_add, add_smul]
  rw [← add_assoc, ← Finset.sum_add_distrib]
  refine congrArg (· + foPoly b b') (Finset.sum_congr rfl fun i _ => ?_)
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  abel

/-! ## 1b. The transported API of the served base modules

`Def_ChapterQuantumGravity3DGauge`, `Def_ChapterQg3DGaugeEsa` and
`Def_ChapterNavierStokesDifferentialL2` are published as *definitions only*: the operators
`qgMom`, `torsionOps`, `signedOp`, `coreOp`, `pgLp` are there, the lemmas that unfold them are
not.  The identification `signedOp κ (qgMom Φ) (torsionOps Φ) = fqOp (diag κ/2) qgFqQ 0 0 0`
has to invert that transport, so this bundle carries the few unfoldings it needs, exactly as
`Def_ChapterSmComparison` carries its own.  Every statement below is its definition read
literally (`rfl`, or one `rw` of a definitional equality) — none of it is new mathematics.
-/

theorem mulXPoly_apply {d : ℕ} (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    mulXPoly i p = X i * p := rfl

theorem momPoly_apply {d : ℕ} (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momPoly i p = C (-Complex.I) * (pderiv i p - C (1 / 2 : ℂ) * (X i * p)) := rfl

theorem coreOp_coreEquiv {d : ℕ}
    (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) : coreOp T (coreEquiv p) = coreEquiv (T p) := by
  simp [coreOp]

theorem coreOp_coe {d : ℕ}
    (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) :
    ((coreOp T (coreEquiv p) : polyGaussCore (d := d)) : L2d d) = pgLp (T p) := by
  rw [coreOp_coreEquiv, coreEquiv_coe]

theorem momPoly_eq_ymMomOp (i : Fin 84) :
    momPoly i = BookProof.YangMillsHermite.momOp i := by
  refine LinearMap.ext fun p => ?_
  rw [momPoly_apply, BookProof.YangMillsHermite.momOp_apply]
  rw [MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul]
  push_cast
  ring

theorem coreRepPoly_equiv (p : MvPolynomial (Fin 84) ℂ) :
    (coreRepPoly 84).equiv p = coreEquiv p := by
  refine Subtype.ext ?_
  rw [(coreRepPoly 84).coe_equiv p, coreEquiv_coe p]

theorem pgLp_eq_pgMap (p : MvPolynomial (Fin 84) ℂ) : pgLp p = pgMap (d := 84) p := rfl

section Signed

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem signedOp_apply {n m : ℕ} (kappa : Fin n → ℝ) (pi : Fin n → D →ₗ[ℂ] D)
    (Bf : Fin m → D →ₗ[ℂ] D) (x : D) :
    signedOp kappa pi Bf x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ i, ((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F))
            + ∑ a, ((Bf a (Bf a x) : D) : F)) := by
  simp [signedOp, signedOpDom]

end Signed

theorem torsionOps_eq {D : Submodule ℂ (L2d 84)} (Φ : CoreRep 84 D) (m : Fin 64) :
    torsionOps Φ m = Φ.op (mulOp (torsionP m)) := rfl

/-! ## 1c. The polynomial identity behind the identification -/

theorem sum_single_X (c : Fin 84) :
    ∑ i : Fin 84, ((if i = c then (1 : ℝ) else 0 : ℝ) : ℂ) • (X i : MvPolynomial (Fin 84) ℂ)
      = X c := by
  rw [Finset.sum_eq_single c]
  · simp
  · intro b _ hb
    simp [hb]
  · intro hc
    exact absurd (Finset.mem_univ c) hc

theorem sum_torsionVec_X (m : Fin 64) :
    ∑ i : Fin 84, ((torsionVec m i : ℝ) : ℂ) • (X i : MvPolynomial (Fin 84) ℂ)
      = torsionP m := by
  have hsplit : ∀ i : Fin 84, ((torsionVec m i : ℝ) : ℂ) • (X i : MvPolynomial (Fin 84) ℂ)
      = ((if i = torsionIdx1 m then (1 : ℝ) else 0 : ℝ) : ℂ) • (X i : MvPolynomial (Fin 84) ℂ)
        - ((if i = torsionIdx2 m then (1 : ℝ) else 0 : ℝ) : ℂ)
            • (X i : MvPolynomial (Fin 84) ℂ) := by
    intro i
    rw [← sub_smul]
    congr 1
    simp [torsionVec]
  rw [Finset.sum_congr rfl fun i _ => hsplit i, Finset.sum_sub_distrib, sum_single_X,
    sum_single_X]
  rfl

theorem triple_swap {α : Type*} [AddCommMonoid α] (F : Fin 64 → Fin 84 → Fin 84 → α) :
    ∑ i : Fin 84, ∑ j : Fin 84, ∑ m : Fin 64, F m i j
      = ∑ m : Fin 64, ∑ i : Fin 84, ∑ j : Fin 84, F m i j := by
  calc ∑ i : Fin 84, ∑ j : Fin 84, ∑ m : Fin 64, F m i j
      = ∑ i : Fin 84, ∑ m : Fin 64, ∑ j : Fin 84, F m i j :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ m : Fin 64, ∑ i : Fin 84, ∑ j : Fin 84, F m i j := Finset.sum_comm

/-- **The torsion potential is the quadratic form of `qgFqQ`**:
`Σ_{i,j} qgFqQ i j · x_i x_j = ½ Σ_m T_m²`. -/
theorem qgFqQ_quadratic_eq :
    ∑ i : Fin 84, ∑ j : Fin 84, ((qgFqQ i j : ℝ) : ℂ)
        • ((X i : MvPolynomial (Fin 84) ℂ) * X j)
      = ((1 / 2 : ℝ) : ℂ) • ∑ m : Fin 64, torsionP m * torsionP m := by
  have hL : ∑ i : Fin 84, ∑ j : Fin 84, ((qgFqQ i j : ℝ) : ℂ)
        • ((X i : MvPolynomial (Fin 84) ℂ) * X j)
      = ∑ i : Fin 84, ∑ j : Fin 84, ∑ m : Fin 64,
          (((1 / 2 : ℝ) : ℂ) * ((torsionVec m i : ℝ) : ℂ) * ((torsionVec m j : ℝ) : ℂ))
            • ((X i : MvPolynomial (Fin 84) ℂ) * X j) := by
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    have hc : ((qgFqQ i j : ℝ) : ℂ)
        = ∑ m : Fin 64,
            (((1 / 2 : ℝ) : ℂ) * ((torsionVec m i : ℝ) : ℂ) * ((torsionVec m j : ℝ) : ℂ)) := by
      rw [qgFqQ]
      push_cast
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun m _ => by ring
    rw [hc, Finset.sum_smul]
  have hR : ((1 / 2 : ℝ) : ℂ) • ∑ m : Fin 64, torsionP m * torsionP m
      = ∑ m : Fin 64, ∑ i : Fin 84, ∑ j : Fin 84,
          (((1 / 2 : ℝ) : ℂ) * ((torsionVec m i : ℝ) : ℂ) * ((torsionVec m j : ℝ) : ℂ))
            • ((X i : MvPolynomial (Fin 84) ℂ) * X j) := by
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [← sum_torsionVec_X m, Finset.sum_mul_sum, Finset.smul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [smul_mul_smul_comm, smul_smul]
    congr 1
    ring
  rw [hL, hR, triple_swap]

theorem qgSignedPoly_apply (kappa : Fin 84 → ℝ) (p : MvPolynomial (Fin 84) ℂ) :
    qgSignedPoly kappa p
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j : Fin 84, ((kappa j : ℝ) : ℂ) • pmom j (pmom j p))
            + ∑ m : Fin 64, torsionP m * (torsionP m * p)) := by
  simp [qgSignedPoly]

theorem weylProd_self (S : MvPolynomial (Fin 84) ℂ →ₗ[ℂ] MvPolynomial (Fin 84) ℂ)
    (p : MvPolynomial (Fin 84) ℂ) : weylProd S S p = S (S p) := by
  simp only [weylProd, LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply]
  rw [← two_smul ℂ (S (S p)), smul_smul]
  norm_num

/-- **The identification at polynomial level.**  The two-signed gravity Hamiltonian is the
general real quadratic Hamiltonian with momentum matrix `diag(κ/2)`, coordinate matrix
`qgFqQ`, no cross term and no first-order term. -/
theorem qgSignedPoly_eq_fqPoly (kappa : Fin 84 → ℝ) :
    qgSignedPoly kappa = fqPoly (qgFqP kappa) qgFqQ 0 0 0 := by
  refine LinearMap.ext fun p => ?_
  have hfo : foPoly (d := 84) 0 0 p = 0 := by simp [foPoly]
  have hmom : ∑ i : Fin 84, ∑ j : Fin 84,
      ((qgFqP kappa i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p
        = ∑ j : Fin 84, ((kappa j / 2 : ℝ) : ℂ) • pmom j (pmom j p) := by
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_eq_single i]
    · rw [qgFqP, if_pos rfl, weylProd_self, momPoly_eq_ymMomOp]
    · intro b _ hb
      simp [qgFqP, Ne.symm hb]
    · intro hi
      exact absurd (Finset.mem_univ i) hi
  have hw : ∀ i j : Fin 84, weylProd (mulXPoly i) (mulXPoly j) p
      = ((X i : MvPolynomial (Fin 84) ℂ) * X j) * p := by
    intro i j
    simp only [weylProd, LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply,
      mulXPoly_apply]
    rw [show (X i : MvPolynomial (Fin 84) ℂ) * (X j * p) = (X i * X j) * p by ring,
      show (X j : MvPolynomial (Fin 84) ℂ) * (X i * p) = (X i * X j) * p by ring,
      ← two_smul ℂ ((X i * X j : MvPolynomial (Fin 84) ℂ) * p), smul_smul]
    norm_num
  have hmul : ∑ i : Fin 84, ∑ j : Fin 84,
      ((qgFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
        = (((1 / 2 : ℝ) : ℂ) • ∑ m : Fin 64, torsionP m * torsionP m) * p := by
    calc ∑ i : Fin 84, ∑ j : Fin 84,
            ((qgFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
        = (∑ i : Fin 84, ∑ j : Fin 84,
            ((qgFqQ i j : ℝ) : ℂ) • ((X i : MvPolynomial (Fin 84) ℂ) * X j)) * p := by
          rw [Finset.sum_mul]
          refine Finset.sum_congr rfl fun i _ => ?_
          rw [Finset.sum_mul]
          refine Finset.sum_congr rfl fun j _ => ?_
          rw [hw i j, smul_mul_assoc]
      _ = _ := by rw [qgFqQ_quadratic_eq]
  have hfq : fqPoly (qgFqP kappa) qgFqQ 0 0 0 p
      = (∑ i : Fin 84, ∑ j : Fin 84,
          ((qgFqP kappa i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p)
        + ∑ i : Fin 84, ∑ j : Fin 84,
            ((qgFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p := by
    rw [fqPoly, fqQuadPoly]
    simp only [LinearMap.add_apply, LinearMap.sum_apply, LinearMap.smul_apply, Pi.zero_apply,
      Complex.ofReal_zero, zero_smul, add_zero, hfo]
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_add_distrib
  rw [qgSignedPoly_apply, hfq, hmom, hmul, smul_add]
  congr 1
  · rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [smul_smul]
    congr 1
    push_cast
    ring
  · rw [Finset.smul_sum, smul_mul_assoc, Finset.sum_mul, Finset.smul_sum]
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [mul_assoc]

theorem pgLp_qgSignedPoly (kappa : Fin 84 → ℝ) (p : MvPolynomial (Fin 84) ℂ) :
    pgLp (qgSignedPoly kappa p)
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j : Fin 84, ((kappa j : ℝ) : ℂ) • pgLp (pmom j (pmom j p)))
            + ∑ m : Fin 64, pgLp (torsionP m * (torsionP m * p))) := by
  rw [qgSignedPoly_apply]
  simp only [pgLp_eq_pgMap, map_smul, map_add, map_sum]

set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core make these defeq checks expensive
set_option maxRecDepth 8000 in
/-- **The identification on the core.**  For every real signature the field-space operator
`signedOp κ (qgMom Φ) (torsionOps Φ)` on the Gauss–polynomial core is the general quadratic
Hamiltonian `fqOp (diag(κ/2)) qgFqQ 0 0 0`. -/
theorem qgSigned_eq_fqOp (kappa : Fin 84 → ℝ) :
    signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84))
      = fqOp (qgFqP kappa) qgFqQ 0 0 0 := by
  refine LinearMap.ext fun x => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := 84)).surjective x
  have hx : ((coreRepPoly 84).equiv.symm (coreEquiv p) : MvPolynomial (Fin 84) ℂ) = p := by
    rw [← coreRepPoly_equiv p, LinearEquiv.symm_apply_apply]
  have hmom : ∀ j : Fin 84,
      ((qgMom (coreRepPoly 84) j (qgMom (coreRepPoly 84) j (coreEquiv p))
        : polyGaussCore (d := 84)) : L2d 84) = pgLp (pmom j (pmom j p)) := by
    intro j
    rw [qgMom, CoreRep.coe_op, CoreRep.op_apply, LinearEquiv.symm_apply_apply, hx]
  have htor : ∀ m : Fin 64,
      ((torsionOps (coreRepPoly 84) m (torsionOps (coreRepPoly 84) m (coreEquiv p))
        : polyGaussCore (d := 84)) : L2d 84) = pgLp (torsionP m * (torsionP m * p)) := by
    intro m
    rw [torsionOps_eq, CoreRep.coe_op, CoreRep.op_apply, LinearEquiv.symm_apply_apply, hx]
    rfl
  rw [signedOp_apply]
  simp only [hmom, htor]
  rw [fqOp, LinearMap.comp_apply, Submodule.subtype_apply, coreOp_coe,
    ← qgSignedPoly_eq_fqPoly kappa, pgLp_qgSignedPoly]

/-- The kinetic-plus-torsion operator with an arbitrary Weyl-ordered quadratic coupling. -/
def qgWithCoupling (kappa : Fin 84 → ℝ) (Q' C : Fin 84 → Fin 84 → ℝ) (b b' : Fin 84 → ℝ) :
    (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84)) + qgCouplingOp Q' C b b'

theorem qgWithCoupling_eq_fqOp (kappa : Fin 84 → ℝ) (Q' C : Fin 84 → Fin 84 → ℝ)
    (b b' : Fin 84 → ℝ) :
    qgWithCoupling kappa Q' C b b' = fqOp (qgFqP kappa) (qgFqQ + Q') C b b' := by
  rw [qgWithCoupling, qgSigned_eq_fqOp, fqOp, qgCouplingOp, fqOp, ← LinearMap.comp_add,
    ← coreOp_add, fqPoly_add_coupling]

/-- **ESA with an arbitrary Weyl-ordered quadratic coupling.**  For every real signature `κ`
and all real coupling data, `½ Σ κ_j π_j² + ½ Σ T_m² + coupling` is essentially self-adjoint
on the Gauss–polynomial core. -/
theorem qgWithCoupling_esa (kappa : Fin 84 → ℝ) (Q' C : Fin 84 → Fin 84 → ℝ)
    (b b' : Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84)) (qgWithCoupling kappa Q' C b b') := by
  rw [qgWithCoupling_eq_fqOp]
  exact fqOp_essentiallySelfAdjoint _ _ _ _ _

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

/-- **The trace parts cancel**: `½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a = ½ Σ (p^{ab} + p^{ba}) E_{ab}`. -/
theorem bookCrossMat_eq_sym (i j : Fin 84) :
    bookCrossMat i j
      = ∑ a : Fin 4, ∑ b : Fin 4, (1 / 2) * (pVec a b j + pVec b a j) * eVec a b i := by
  simp only [bookCrossMat, calSVec, eTrVec, Fin.sum_univ_four]
  simp only [Fin.isValue, ↓reduceIte, Fin.reduceEq]
  ring

/-- The cross terms are genuinely present: the coefficient of `½(x π + π x)` for the pair
(`∂_0 e_1{}^1`, `π_{e_1{}^1}`) is `1`. -/
theorem bookCrossMat_idx11 : bookCrossMat (idxDE 0 1 1) (idxE 1 1) = 1 := by
  rw [bookCrossMat_eq_sym]
  simp only [pVec, eVec, qgEta, idxE, idxDE, Fin.sum_univ_four, Fin.ext_iff]
  norm_num

/-- **The 3D gravity Hamiltonian with the book's cross terms**: hyperbolic signature
`qgKappa`, torsion potential, Weyl-ordered `½ 𝒮·E + ⅓ 𝒫·E`, and a real quadratic bracket
`Q'` (flat density `e = 1`). -/
def qg3DCrossHamiltonian (Q' : Fin 84 → Fin 84 → ℝ) :
    (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  qg3DHamiltonian (coreRepPoly 84) + qgCouplingOp Q' bookCrossMat 0 0

/-- The cross-term Hamiltonian is the general real quadratic Hamiltonian with kinetic matrix
`diag(κ/2)`, coordinate matrix `qgFqQ + Q'` and cross matrix `bookCrossMat`. -/
theorem qg3DCross_eq_fqOp (Q' : Fin 84 → Fin 84 → ℝ) :
    qg3DCrossHamiltonian Q' = fqOp (qgFqP qgKappa) (qgFqQ + Q') bookCrossMat 0 0 := by
  rw [← qgWithCoupling_eq_fqOp, qg3DCrossHamiltonian, qgWithCoupling, qg3DHamiltonian]

/-- **ESA of the 3D gravity Hamiltonian with the cross terms included**, for every real
quadratic bracket `Q'`. -/
theorem qg3DCross_esa (Q' : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84)) (qg3DCrossHamiltonian Q') := by
  rw [qg3DCross_eq_fqOp]
  exact fqOp_essentiallySelfAdjoint _ _ _ _ _

/-- **The complete unitary flow** of the gravity Hamiltonian with the cross terms (Stone). -/
theorem qg3DCross_stone_flow (Q' : Fin 84 → Fin 84 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d 84)) (U : ℝ → (L2d 84 →L[ℂ] L2d 84)),
      IsSelfAdjointExtension (qg3DCrossHamiltonian Q') T.op ∧ IsStoneFlow T U := by
  rw [qg3DCross_eq_fqOp]
  exact fqOp_stone_flow _ _ _ _ _

/-! ## 3. Second quantization -/

theorem qg3DCross_symmetricOn (Q' : Fin 84 → Fin 84 → ℝ) :
    SymmetricOn (polyGaussCore (d := 84)) (qg3DCrossHamiltonian Q') := by
  rw [qg3DCross_eq_fqOp]
  exact fqOp_symmetric _ _ _ _ _

/-- **The enclosure `dΓ(h)`** of the cross-term Hamiltonian (creation left / annihilation
right, `dGammaCoreOp`) is essentially self-adjoint on the finite-particle domain over the
Gauss–polynomial core. -/
theorem qg3DCross_dGamma_esa (Q' : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 84) (polyGaussCore (d := 84))
        (polyGaussCore (d := 84)) n))
      (dGammaCoreOp (L2dSpace 84) (polyGaussCore (d := 84))
        (qg3DCrossHamiltonian Q') (polyGaussCore (d := 84))) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := L2dSpace 84)
    (qg3DCrossHamiltonian Q') polyGaussCore_dense (qg3DCross_symmetricOn Q')
    (qg3DCross_esa Q')

/-- **The same in the occupation-number spelling**: the second quantization
`Σ_{j,k} ⟪ψ_j, h ψ_k⟫ a†_j a_k` of the cross-term Hamiltonian in the product Hermite basis is
essentially self-adjoint on the finite-occupation core of the Fock space. -/
theorem qg3DCross_dGammaOp_esa (e : ℕ ≃ (Fin 84 →₀ ℕ)) (Q' : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (BookProof.NavierStokesFlow.lpFiniteModes Conf)
      (dGammaOp (hermCol e (fqPoly (qgFqP qgKappa) (qgFqQ + Q') bookCrossMat 0 0))) :=
  dGamma_fqPoly_essentiallySelfAdjointOn_core e _ _ _ _ _

end

end BookProof.Qg3DCrossTermEsa
