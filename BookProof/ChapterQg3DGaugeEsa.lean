import Mathlib
import BookProof.ChapterQuantumGravity3DGauge
import BookProof.ChapterFullQuadraticEsa

/-!
# Essential self-adjointness of the 3D gauge-fixed gravity Hamiltonian on the
Gauss–polynomial core of `L²(ℝ⁸⁴)`

`BookProof.ChapterQuantumGravity3DGauge` builds the concrete densitized, Weyl-ordered
3D gauge-fixed gravity Hamiltonian

`H = ½ Σ_j κ_j π_j² + ½ Σ_m T_m²`,  `κ = qgKappa`,  `T_m = ∂_μ e_ν^a − ∂_ν e_μ^a`,

on a Gauss–polynomial core of `L²(ℝ⁸⁴)` and proves it symmetric there, but stops short of a
self-adjointness statement: the signature `qgKappa` is *hyperbolic*
(`qgKappa_conformal_neg`), so the Friedrichs machinery — which needs a semibounded form —
does not apply to it.

This module closes that gap along the route recorded as the strategy of record in
`CONSOLIDATED_PLAN.md` §10.2b: **the one-particle operator is quadratic in the canonical
pair**, and the general real quadratic Hamiltonian is already known to be essentially
self-adjoint on the plain Gauss–polynomial core by
`BookProof.FullQuadratic.fqOp_essentiallySelfAdjoint` (proved through the Carleman-flux
criterion on the simplex shells, with no sign, ellipticity or definiteness hypothesis).
What is needed is therefore only an **identification**: the gravity Hamiltonian *is* one of
those quadratic Hamiltonians, for an explicit pair of real coefficient matrices.

## What is proved

* `torsionVec`, `qgFqQ`, `qgFqP` — the coefficient data: `T_m = Σ_i (torsionVec m i)·x_i` is
  a *linear* form in the coordinates, so `½ Σ_m T_m²` is the quadratic form of the
  (positive semidefinite) Gram matrix `qgFqQ = ½ Σ_m v_m v_mᵀ`, while the kinetic term is
  the diagonal momentum matrix `qgFqP κ = diag(κ/2)`.
* `sum_torsionVec_X`, `qgFqQ_quadratic_eq` — the two polynomial identities behind it.
* `qgSignedPoly_eq_fqPoly` — the operator identity at polynomial level:
  `½ Σ_j κ_j π_j² + ½ Σ_m T_m² = fqPoly (diag(κ/2)) qgFqQ 0 0 0` for **every** real
  signature `κ`.
* `qgSigned_eq_fqOp` — the same identity on the core of `L²(ℝ⁸⁴)`.
* `qgSigned_essentiallySelfAdjointOn_core` — **the headline in general form**: for every
  real signature `κ` the operator `½ Σ_j κ_j π_j² + ½ Σ_m T_m²` is essentially
  self-adjoint on the Gauss–polynomial core.
* `qg3D_essentiallySelfAdjointOn_core` — the physical, *hyperbolic* instance: the gravity
  Hamiltonian `qg3DHamiltonian` itself is essentially self-adjoint on the core, so its
  closure is the unique self-adjoint realization, and `qg3D_stone_flow` is the complete
  unitary group it generates (Stone).
* `qg3DElliptic_essentiallySelfAdjointOn_core` — the elliptic sector, for comparison: it is
  the same statement with `qgKappaElliptic`, and it *upgrades* the Friedrichs extension of
  `ChapterQuantumGravity3DGauge` from existence to uniqueness.

## Honest boundary

This is the **one-particle** operator of the final-Hamiltonian doctrine — the `h` of
`H = Σᵢⱼ hᵢⱼ C†(eᵢ) A(eⱼ)` — realized on the 84 field-space coordinates, with the torsion
potential of `ChapterQuantumGravity3DGauge`. No mass gap, no spectrum and no continuum
limit is claimed; the Fock lift is the separate `dΓ` layer. The statement is essential
self-adjointness on the Gauss–polynomial core of `L²(ℝ⁸⁴)`, which is dense
(`polyGaussCore_dense`).

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.Qg3DGaugeEsa

open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

/-! ## 1. The torsion terms as linear forms in the coordinates -/

/-- The first spacetime index carried by the `m`-th torsion operator. -/
def torsionMu (m : Fin 64) : Fin 4 := ⟨m.val / 16, by omega⟩

/-- The second spacetime index carried by the `m`-th torsion operator. -/
def torsionNu (m : Fin 64) : Fin 4 := ⟨m.val / 4 % 4, by omega⟩

/-- The internal index carried by the `m`-th torsion operator. -/
def torsionA (m : Fin 64) : Fin 4 := ⟨m.val % 4, by omega⟩

/-- The polynomial momentum operator `π_j = −i ∂_j` on the Gauss–polynomial coordinates
(the `BookProof.YangMillsHermite` one; abbreviated here to keep the formulas readable). -/
abbrev pmom (j : Fin 84) : MvPolynomial (Fin 84) ℂ →ₗ[ℂ] MvPolynomial (Fin 84) ℂ :=
  YangMillsHermite.momOp j

/-- The polynomial of the `m`-th torsion term, `T_m = ∂_μ e_ν^a − ∂_ν e_μ^a`. -/
def torsionP (m : Fin 64) : MvPolynomial (Fin 84) ℂ :=
  torsionPoly (torsionMu m) (torsionNu m) (torsionA m)

theorem torsionOps_eq {D : Submodule ℂ (L2d 84)} (Φ : CoreRep 84 D) (m : Fin 64) :
    torsionOps Φ m = Φ.op (mulOp (torsionP m)) := rfl

/-- The coordinate index `∂_μ e_ν^a` of the `m`-th torsion term. -/
def torsionIdx1 (m : Fin 64) : Fin 84 := idxDE (torsionMu m) (torsionNu m) (torsionA m)

/-- The coordinate index `∂_ν e_μ^a` subtracted in the `m`-th torsion term. -/
def torsionIdx2 (m : Fin 64) : Fin 84 := idxDE (torsionNu m) (torsionMu m) (torsionA m)

/-- **The torsion term is a linear form**: `T_m = Σ_i (torsionVec m i)·x_i`, with the
coefficient vector `v_m = e_{∂_μ e_ν^a} − e_{∂_ν e_μ^a}`. -/
def torsionVec (m : Fin 64) (i : Fin 84) : ℝ :=
  (if i = torsionIdx1 m then 1 else 0) - (if i = torsionIdx2 m then 1 else 0)

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

/-! ## 2. The coefficient matrices of the quadratic Hamiltonian -/

/-- The momentum matrix of the gravity Hamiltonian: the diagonal `diag(κ/2)`. -/
def qgFqP (kappa : Fin 84 → ℝ) (j k : Fin 84) : ℝ := if j = k then kappa j / 2 else 0

/-- The coordinate matrix of the gravity Hamiltonian: `½ Σ_m v_m v_mᵀ`, the Gram matrix of
the torsion coefficient vectors. -/
def qgFqQ (i j : Fin 84) : ℝ := (1 / 2) * ∑ m : Fin 64, torsionVec m i * torsionVec m j

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

/-! ## 3. The identification with the general quadratic Hamiltonian -/

/-- The polynomial-level two-signed gravity Hamiltonian `½ Σ_j κ_j π_j² + ½ Σ_m T_m²`, for
an arbitrary real signature `κ`. -/
def qgSignedPoly (kappa : Fin 84 → ℝ) :
    MvPolynomial (Fin 84) ℂ →ₗ[ℂ] MvPolynomial (Fin 84) ℂ :=
  ((1 / 2 : ℝ) : ℂ) •
    ((∑ j : Fin 84, ((kappa j : ℝ) : ℂ) • (pmom j).comp (pmom j))
      + ∑ m : Fin 64, (mulOp (torsionP m)).comp (mulOp (torsionP m)))

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

/-! ## 4. Transport to the core of `L²(ℝ⁸⁴)` -/

theorem coreRepPoly_equiv (p : MvPolynomial (Fin 84) ℂ) :
    (coreRepPoly 84).equiv p = coreEquiv p := by
  refine Subtype.ext ?_
  rw [(coreRepPoly 84).coe_equiv p, coreEquiv_coe p]

theorem pgLp_eq_pgMap (p : MvPolynomial (Fin 84) ℂ) : pgLp p = pgMap (d := 84) p := rfl

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

/-! ## 5. Essential self-adjointness -/

/-- **The two-signed gravity Hamiltonian is essentially self-adjoint on the Gauss–polynomial
core**, for *every* real signature `κ` — in particular with no positivity, ellipticity or
definiteness assumption on the kinetic term. -/
theorem qgSigned_essentiallySelfAdjointOn_core (kappa : Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84))
      (signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84))) := by
  rw [qgSigned_eq_fqOp kappa]
  exact fqOp_essentiallySelfAdjoint (qgFqP kappa) qgFqQ 0 0 0

/-- **The headline.**  The concrete 3D gauge-fixed gravity Hamiltonian `qg3DHamiltonian` —
densitized, Weyl-ordered, with the physical *hyperbolic* signature `qgKappa` and the torsion
potential — is essentially self-adjoint on the Gauss–polynomial core of `L²(ℝ⁸⁴)`: its
closure is the unique self-adjoint realization. -/
theorem qg3D_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84)) (qg3DHamiltonian (coreRepPoly 84)) :=
  qgSigned_essentiallySelfAdjointOn_core qgKappa

/-- **The complete unitary flow of the gravity Hamiltonian**, by Stone's theorem applied to
the unique self-adjoint extension supplied by essential self-adjointness. -/
theorem qg3D_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (L2d 84)) (U : ℝ → (L2d 84 →L[ℂ] L2d 84)),
      IsSelfAdjointExtension (qg3DHamiltonian (coreRepPoly 84)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (qg3D_symmetricOn (coreRepPoly 84))
    qg3D_essentiallySelfAdjointOn_core

/-- The elliptic sector, for comparison: essential self-adjointness upgrades its Friedrichs
extension from existence to uniqueness. -/
theorem qg3DElliptic_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84))
      (qg3DEllipticHamiltonian (coreRepPoly 84)) :=
  qgSigned_essentiallySelfAdjointOn_core qgKappaElliptic

end

end BookProof.Qg3DGaugeEsa
