import Mathlib
import BookProof.ChapterQg3DGaugeEsa
import BookProof.ChapterQgHermiteOscillatorEsa
import BookProof.ChapterDirectSumEsa

/-!
# The full quantum-gravity Hamiltonian on the outer Fock space

`BookProof.ChapterQg3DGaugeEsa` proves that the **one-particle** gauge-fixed 3D gravity
Hamiltonian — the `84`-dimensional signed kinetic form plus the `64` squared torsion
constraints — is essentially self-adjoint on the Gauss–polynomial (Hermite) core of
`L²(ℝ⁸⁴)`.  This module lifts that statement to the **outer Fock space**

`𝔉 = ⊕ₙ L²(ℝ^{84n})`,

the `ℓ²`-direct sum of the `n`-particle sectors (the finite-particle Fock space of
distinguishable field-space excitations already used by
`BookProof.ChapterQgOneParticleCcEsa`), and proves that the second-quantized Hamiltonian
`H = Σₚ h^{(p)}` — the one-particle Hamiltonian acting in each particle's own `84`
field-space coordinates — is essentially self-adjoint on the finite-particle core.

## The mechanism

The `n`-particle sector Hamiltonian is *again* a real quadratic Hamiltonian, now in `84n`
degrees of freedom: the momentum block is the one-particle signature repeated once per
particle, and the potential block is the Gram matrix of the `64n` torsion forms
(`gramQ`).  So the general quadratic instrument
`BookProof.FullQuadratic.fqOp_essentiallySelfAdjoint` — the Carleman-flux argument on the
simplex shells, which needs no ellipticity, no definiteness and no sign condition —
applies verbatim to every sector, and `BookProof.DirectSumEsa` glues the sectors.

## What is proved

* `linForm`, `gramQ`, `diagP`, `sqSumPoly`, `sqSumOp` — the operator
  `½ Σⱼ κⱼ πⱼ² + ½ Σᵣ Lᵣ²` for an arbitrary real signature `κ` and an arbitrary finite
  family of linear forms `Lᵣ`, on the Gauss–polynomial core of `L²(ℝᴰ)`;
* `sqSumPoly_eq_fqPoly`, `sqSumOp_eq_fqOp` — its identification with the general
  quadratic Hamiltonian `fqOp (diag κ/2) (gramQ v) 0 0 0`, whence
  `sqSumOp_symmetricOn` and `sqSumOp_essentiallySelfAdjointOn`;
* `pcoord`, `partOf`, `modeOf`, `qgKappaN`, `qgTorsionVecN`, `qgSectorHam` — the
  `n`-particle sector data and the sector Hamiltonian;
* `linForm_qgTorsionVecN`, `qgSectorPoly_eq_sum_particles` — the sector Hamiltonian **is**
  the sum over the particles of the one-particle gravity Hamiltonian, each acting in its
  own particle's coordinates: the torsion forms of particle `p` are the one-particle
  torsion forms in the coordinates `pcoord p ·`;
* `qgSectorHam_symmetricOn`, `qgSectorHam_essentiallySelfAdjointOn` — the sector
  statements;
* `qgOuterFock`, `qgOuterCore`, `qgOuterCore_dense`, `qgOuterHam` — the outer Fock space,
  its finite-particle core and the full Hamiltonian;
* `qgOuterFock_esa` — **the headline**: the full gravity Hamiltonian is essentially
  self-adjoint on the finite-particle core of the outer Fock space, and
  `qgOuterHam_stone_flow` is the complete unitary group `e^{−itH}` it generates;
* `qgOuterN`, `qgOuterN_symmetricOn`, `dsOp_quadForm_nonneg`, `qgOuterN_quadForm_nonneg`,
  `qgOuterN_esa` — the lifted positive one-particle operator `dΓ(N₁)`,
  `N₁ = −Δ + ‖x‖²/4`, which is the comparison operator of the Faris–Lavine route;
  `BookProof.ChapterQgOuterFockFarisLavine` lifts its Friedrichs extension to the outer
  Fock space and runs Faris–Lavine there.

## Honest boundary

The Fock space is the direct sum of the sectors — *distinguishable* excitations, no
symmetrization; the Hamiltonian is particle-number preserving (block diagonal), which is
what makes the direct-sum gluing available.  No interaction between different particle
numbers is included, and nothing here is a statement about a continuum field theory.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgOuterFock

open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.QgHermiteOscillator
open BookProof.DirectSumEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

/-! ## 1. Kinetic-plus-squares Hamiltonians in `d` dimensions -/

variable {D : ℕ}

/-- A linear form `Σᵢ vᵢ xᵢ` in the coordinates. -/
def linForm (v : Fin D → ℝ) : MvPolynomial (Fin D) ℂ :=
  ∑ i : Fin D, ((v i : ℝ) : ℂ) • X i

/-- The Gram matrix `½ Σ_r v_r v_rᵀ` of a finite family of linear forms. -/
def gramQ {R : Type*} [Fintype R] (v : R → Fin D → ℝ) (i j : Fin D) : ℝ :=
  (1 / 2) * ∑ r : R, v r i * v r j

/-- The diagonal momentum matrix `diag(κ/2)`. -/
def diagP (kappa : Fin D → ℝ) (j k : Fin D) : ℝ := if j = k then kappa j / 2 else 0

/-- The polynomial-level Hamiltonian `½ Σ_j κ_j π_j² + ½ Σ_r L_r²`, for an arbitrary real
signature `κ` and an arbitrary finite family of linear forms `L_r = Σᵢ v_r i xᵢ`. -/
def sqSumPoly {R : Type*} [Fintype R] (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    MvPolynomial (Fin D) ℂ →ₗ[ℂ] MvPolynomial (Fin D) ℂ :=
  ((1 / 2 : ℝ) : ℂ) •
    ((∑ j : Fin D, ((kappa j : ℝ) : ℂ) •
        (YangMillsHermite.momOp j).comp (YangMillsHermite.momOp j))
      + ∑ r : R, (YangMillsHermite.mulOp (linForm (v r))).comp
          (YangMillsHermite.mulOp (linForm (v r))))

theorem triple_swap' {R : Type*} [Fintype R] {α : Type*} [AddCommMonoid α]
    (F : R → Fin D → Fin D → α) :
    ∑ i : Fin D, ∑ j : Fin D, ∑ r : R, F r i j
      = ∑ r : R, ∑ i : Fin D, ∑ j : Fin D, F r i j := by
  calc ∑ i : Fin D, ∑ j : Fin D, ∑ r : R, F r i j
      = ∑ i : Fin D, ∑ r : R, ∑ j : Fin D, F r i j :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ r : R, ∑ i : Fin D, ∑ j : Fin D, F r i j := Finset.sum_comm

/-- **The sum of squares is the quadratic form of the Gram matrix.** -/
theorem gramQ_quadratic_eq {R : Type*} [Fintype R] (v : R → Fin D → ℝ) :
    ∑ i : Fin D, ∑ j : Fin D, ((gramQ v i j : ℝ) : ℂ)
        • ((X i : MvPolynomial (Fin D) ℂ) * X j)
      = ((1 / 2 : ℝ) : ℂ) • ∑ r : R, linForm (v r) * linForm (v r) := by
  have hL : ∑ i : Fin D, ∑ j : Fin D, ((gramQ v i j : ℝ) : ℂ)
        • ((X i : MvPolynomial (Fin D) ℂ) * X j)
      = ∑ i : Fin D, ∑ j : Fin D, ∑ r : R,
          (((1 / 2 : ℝ) : ℂ) * ((v r i : ℝ) : ℂ) * ((v r j : ℝ) : ℂ))
            • ((X i : MvPolynomial (Fin D) ℂ) * X j) := by
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    have hc : ((gramQ v i j : ℝ) : ℂ)
        = ∑ r : R, (((1 / 2 : ℝ) : ℂ) * ((v r i : ℝ) : ℂ) * ((v r j : ℝ) : ℂ)) := by
      rw [gramQ]
      push_cast
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun r _ => by ring
    rw [hc, Finset.sum_smul]
  have hR : ((1 / 2 : ℝ) : ℂ) • ∑ r : R, linForm (v r) * linForm (v r)
      = ∑ r : R, ∑ i : Fin D, ∑ j : Fin D,
          (((1 / 2 : ℝ) : ℂ) * ((v r i : ℝ) : ℂ) * ((v r j : ℝ) : ℂ))
            • ((X i : MvPolynomial (Fin D) ℂ) * X j) := by
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun r _ => ?_
    rw [linForm, Finset.sum_mul_sum, Finset.smul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [smul_mul_smul_comm, smul_smul]
    congr 1
    ring
  rw [hL, hR, triple_swap']

theorem weylProd_self' (S : MvPolynomial (Fin D) ℂ →ₗ[ℂ] MvPolynomial (Fin D) ℂ)
    (p : MvPolynomial (Fin D) ℂ) : weylProd S S p = S (S p) := by
  simp only [weylProd, LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply]
  rw [← two_smul ℂ (S (S p)), smul_smul]
  norm_num

/-- **The identification with the general quadratic Hamiltonian.** -/
theorem sqSumPoly_eq_fqPoly {R : Type*} [Fintype R] (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    sqSumPoly kappa v = fqPoly (diagP kappa) (gramQ v) 0 0 0 := by
  refine LinearMap.ext fun p => ?_
  have hfo : foPoly (d := D) 0 0 p = 0 := by simp [foPoly]
  have hmom : ∑ i : Fin D, ∑ j : Fin D,
      ((diagP kappa i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p
        = ∑ j : Fin D, ((kappa j / 2 : ℝ) : ℂ)
            • YangMillsHermite.momOp j (YangMillsHermite.momOp j p) := by
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_eq_single i]
    · rw [diagP, if_pos rfl, weylProd_self', momPoly_eq_ymMomOp]
    · intro b _ hb
      simp [diagP, Ne.symm hb]
    · intro hi
      exact absurd (Finset.mem_univ i) hi
  have hw : ∀ i j : Fin D, weylProd (mulXPoly i) (mulXPoly j) p
      = ((X i : MvPolynomial (Fin D) ℂ) * X j) * p := by
    intro i j
    simp only [weylProd, LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply,
      mulXPoly_apply]
    rw [show (X i : MvPolynomial (Fin D) ℂ) * (X j * p) = (X i * X j) * p by ring,
      show (X j : MvPolynomial (Fin D) ℂ) * (X i * p) = (X i * X j) * p by ring,
      ← two_smul ℂ ((X i * X j : MvPolynomial (Fin D) ℂ) * p), smul_smul]
    norm_num
  have hmul : ∑ i : Fin D, ∑ j : Fin D,
      ((gramQ v i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
        = (((1 / 2 : ℝ) : ℂ) • ∑ r : R, linForm (v r) * linForm (v r)) * p := by
    calc ∑ i : Fin D, ∑ j : Fin D,
            ((gramQ v i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
        = (∑ i : Fin D, ∑ j : Fin D,
            ((gramQ v i j : ℝ) : ℂ) • ((X i : MvPolynomial (Fin D) ℂ) * X j)) * p := by
          rw [Finset.sum_mul]
          refine Finset.sum_congr rfl fun i _ => ?_
          rw [Finset.sum_mul]
          refine Finset.sum_congr rfl fun j _ => ?_
          rw [hw i j, smul_mul_assoc]
      _ = _ := by rw [gramQ_quadratic_eq]
  have hfq : fqPoly (diagP kappa) (gramQ v) 0 0 0 p
      = (∑ i : Fin D, ∑ j : Fin D,
          ((diagP kappa i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p)
        + ∑ i : Fin D, ∑ j : Fin D,
            ((gramQ v i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p := by
    rw [fqPoly, fqQuadPoly]
    simp only [LinearMap.add_apply, LinearMap.sum_apply, LinearMap.smul_apply, Pi.zero_apply,
      Complex.ofReal_zero, zero_smul, add_zero, hfo]
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_add_distrib
  have hlhs : sqSumPoly kappa v p
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j : Fin D, ((kappa j : ℝ) : ℂ)
              • YangMillsHermite.momOp j (YangMillsHermite.momOp j p))
            + ∑ r : R, linForm (v r) * (linForm (v r) * p)) := by
    simp [sqSumPoly]
  rw [hlhs, hfq, hmom, hmul, smul_add]
  congr 1
  · rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [smul_smul]
    congr 1
    push_cast
    ring
  · rw [Finset.smul_sum, smul_mul_assoc, Finset.sum_mul, Finset.smul_sum]
    refine Finset.sum_congr rfl fun r _ => ?_
    rw [mul_assoc]

/-- The operator `½ Σ_j κ_j π_j² + ½ Σ_r L_r²` on the Gauss–polynomial core of `L²(ℝᴰ)`. -/
def sqSumOp {R : Type*} [Fintype R] (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    (polyGaussCore (d := D)) →ₗ[ℂ] L2d D :=
  (polyGaussCore (d := D)).subtype ∘ₗ coreOp (sqSumPoly kappa v)

theorem sqSumOp_eq_fqOp {R : Type*} [Fintype R] (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    sqSumOp kappa v = fqOp (diagP kappa) (gramQ v) 0 0 0 := by
  rw [sqSumOp, fqOp, sqSumPoly_eq_fqPoly]

theorem sqSumOp_symmetricOn {R : Type*} [Fintype R] (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    SymmetricOn (polyGaussCore (d := D)) (sqSumOp kappa v) := by
  rw [sqSumOp_eq_fqOp]
  exact fqOp_symmetric _ _ _ _ _

theorem sqSumOp_essentiallySelfAdjointOn {R : Type*} [Fintype R] (kappa : Fin D → ℝ)
    (v : R → Fin D → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := D)) (sqSumOp kappa v) := by
  rw [sqSumOp_eq_fqOp]
  exact fqOp_essentiallySelfAdjoint _ _ _ _ _

/-! ## 2. The `n`-particle sector of the gravity Hamiltonian -/

/-- The coordinate of the `i`-th field-space direction of the `p`-th particle. -/
def pcoord {n : ℕ} (p : Fin n) (i : Fin 84) : Fin (n * 84) := finProdFinEquiv (p, i)

/-- The particle carrying the coordinate `I`. -/
def partOf {n : ℕ} (I : Fin (n * 84)) : Fin n := (finProdFinEquiv.symm I).1

/-- The field-space direction of the coordinate `I`. -/
def modeOf {n : ℕ} (I : Fin (n * 84)) : Fin 84 := (finProdFinEquiv.symm I).2

@[simp] theorem partOf_pcoord {n : ℕ} (p : Fin n) (i : Fin 84) : partOf (pcoord p i) = p := by
  simp [partOf, pcoord]

@[simp] theorem modeOf_pcoord {n : ℕ} (p : Fin n) (i : Fin 84) : modeOf (pcoord p i) = i := by
  simp [modeOf, pcoord]

@[simp] theorem pcoord_partOf_modeOf {n : ℕ} (I : Fin (n * 84)) :
    pcoord (partOf I) (modeOf I) = I := by
  simp only [pcoord, partOf, modeOf, Prod.mk.eta, Equiv.apply_symm_apply]

/-- The `n`-particle signature: the one-particle signature in every particle's block. -/
def qgKappaN (n : ℕ) (I : Fin (n * 84)) : ℝ := qgKappa (modeOf I)

/-- The `n`-particle torsion family: the one-particle torsion forms, one copy per
particle. -/
def qgTorsionVecN (n : ℕ) (r : Fin n × Fin 64) (I : Fin (n * 84)) : ℝ :=
  if partOf I = r.1 then torsionVec r.2 (modeOf I) else 0

/-- **The `n`-particle gravity Hamiltonian** `Σ_p h^{(p)}` on the Gauss–polynomial core of
`L²(ℝ^{84n})`. -/
def qgSectorHam (n : ℕ) : (polyGaussCore (d := n * 84)) →ₗ[ℂ] L2d (n * 84) :=
  sqSumOp (qgKappaN n) (qgTorsionVecN n)

theorem qgKappaN_pcoord {n : ℕ} (p : Fin n) (i : Fin 84) :
    qgKappaN n (pcoord p i) = qgKappa i := by simp [qgKappaN]

/-- Reindexing a sum over the `84n` coordinates as a sum over particles and field-space
directions. -/
theorem sum_reindex_particles {n : ℕ} {α : Type*} [AddCommMonoid α] (F : Fin (n * 84) → α) :
    ∑ I : Fin (n * 84), F I = ∑ p : Fin n, ∑ j : Fin 84, F (pcoord p j) := by
  calc ∑ I : Fin (n * 84), F I = ∑ qi : Fin n × Fin 84, F (pcoord qi.1 qi.2) :=
        (Fintype.sum_equiv finProdFinEquiv (fun qi => F (pcoord qi.1 qi.2)) F fun _ => rfl).symm
    _ = ∑ p : Fin n, ∑ j : Fin 84, F (pcoord p j) :=
        Fintype.sum_prod_type (fun qi : Fin n × Fin 84 => F (pcoord qi.1 qi.2))

theorem sum_single_block {n : ℕ} (p : Fin n) (c : Fin 84) :
    ∑ i : Fin 84, ((if i = c then (1 : ℝ) else 0 : ℝ) : ℂ)
        • (X (pcoord p i) : MvPolynomial (Fin (n * 84)) ℂ) = X (pcoord p c) := by
  rw [Finset.sum_eq_single c]
  · simp
  · intro b _ hb
    simp [hb]
  · intro hc
    exact absurd (Finset.mem_univ c) hc

/-- **The `p`-th torsion form is the one-particle torsion form in the `p`-th particle's
coordinates.** -/
theorem linForm_qgTorsionVecN {n : ℕ} (p : Fin n) (m : Fin 64) :
    linForm (qgTorsionVecN n (p, m))
      = X (pcoord p (torsionIdx1 m)) - X (pcoord p (torsionIdx2 m)) := by
  classical
  rw [linForm, sum_reindex_particles, Finset.sum_eq_single p]
  · have hsplit : ∀ i : Fin 84, ((qgTorsionVecN n (p, m) (pcoord p i) : ℝ) : ℂ)
        • (X (pcoord p i) : MvPolynomial (Fin (n * 84)) ℂ)
        = ((if i = torsionIdx1 m then (1 : ℝ) else 0 : ℝ) : ℂ) • X (pcoord p i)
          - ((if i = torsionIdx2 m then (1 : ℝ) else 0 : ℝ) : ℂ) • X (pcoord p i) := by
      intro i
      have hcoef : qgTorsionVecN n (p, m) (pcoord p i) = torsionVec m i := by
        simp [qgTorsionVecN]
      rw [hcoef, ← sub_smul]
      congr 1
      simp [torsionVec]
    rw [Finset.sum_congr rfl fun i _ => hsplit i, Finset.sum_sub_distrib, sum_single_block,
      sum_single_block]
  · intro q _ hq
    refine Finset.sum_eq_zero fun i _ => ?_
    have hcoef : qgTorsionVecN n (p, m) (pcoord q i) = 0 := by
      simp [qgTorsionVecN, hq]
    rw [hcoef]
    simp
  · intro hp
    exact absurd (Finset.mem_univ p) hp

/-- The one-particle torsion form, in the coordinates of the `p`-th particle. -/
def qgTorsionBlock {n : ℕ} (p : Fin n) (m : Fin 64) : MvPolynomial (Fin (n * 84)) ℂ :=
  X (pcoord p (torsionIdx1 m)) - X (pcoord p (torsionIdx2 m))

/-- **The `n`-particle Hamiltonian is the sum over the particles of the one-particle
Hamiltonian**, each acting in its own particle's `84` field-space coordinates. -/
theorem qgSectorPoly_eq_sum_particles (n : ℕ) :
    sqSumPoly (qgKappaN n) (qgTorsionVecN n)
      = ((1 / 2 : ℝ) : ℂ) • ∑ p : Fin n,
          ((∑ j : Fin 84, ((qgKappa j : ℝ) : ℂ) •
              (YangMillsHermite.momOp (pcoord p j)).comp (YangMillsHermite.momOp (pcoord p j)))
            + ∑ m : Fin 64, (YangMillsHermite.mulOp (qgTorsionBlock p m)).comp
                (YangMillsHermite.mulOp (qgTorsionBlock p m))) := by
  rw [sqSumPoly, Finset.sum_add_distrib]
  congr 2
  · rw [sum_reindex_particles]
    exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun j _ => by
      rw [qgKappaN_pcoord]
  · rw [Fintype.sum_prod_type (fun r : Fin n × Fin 64 =>
      (YangMillsHermite.mulOp (linForm (qgTorsionVecN n r))).comp
        (YangMillsHermite.mulOp (linForm (qgTorsionVecN n r))))]
    exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun m _ => by
      rw [linForm_qgTorsionVecN p m]
      rfl

theorem qgSectorHam_symmetricOn (n : ℕ) :
    SymmetricOn (polyGaussCore (d := n * 84)) (qgSectorHam n) :=
  sqSumOp_symmetricOn _ _

theorem qgSectorHam_essentiallySelfAdjointOn (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 84)) (qgSectorHam n) :=
  sqSumOp_essentiallySelfAdjointOn _ _

/-! ## 3. The outer Fock space and the full Hamiltonian -/

/-- **The outer Fock space** over the gravity one-particle space `L²(ℝ⁸⁴)`. -/
abbrev qgOuterFock := lp (fun n : ℕ => L2d (n * 84)) 2

/-- The finite-particle core: the algebraic direct sum of the sector Gauss–polynomial
cores. -/
def qgOuterCore : Submodule ℂ qgOuterFock :=
  dsCore (fun n : ℕ => polyGaussCore (d := n * 84))

theorem qgOuterCore_dense : Dense ((qgOuterCore : Submodule ℂ qgOuterFock) : Set qgOuterFock) :=
  dsCore_dense fun _ => polyGaussCore_dense

/-- **The full gravity Hamiltonian on the outer Fock space.** -/
def qgOuterHam : qgOuterCore →ₗ[ℂ] qgOuterFock := dsOp (fun n : ℕ => qgSectorHam n)

theorem qgOuterHam_symmetricOn : SymmetricOn qgOuterCore qgOuterHam :=
  dsOp_symmetricOn _ fun n => qgSectorHam_symmetricOn n

/-- **The headline.** -/
theorem qgOuterFock_esa : EssentiallySelfAdjointOn qgOuterCore qgOuterHam :=
  dsOp_essentiallySelfAdjointOn _ fun n => qgSectorHam_essentiallySelfAdjointOn n

theorem qgOuterHam_stone_flow :
    ∃ (T : UnboundedSelfAdjoint qgOuterFock) (U : ℝ → (qgOuterFock →L[ℂ] qgOuterFock)),
      IsSelfAdjointExtension qgOuterHam T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ qgOuterCore_dense qgOuterHam_symmetricOn qgOuterFock_esa

/-! ## 4. The lifted comparison operator -/

/-- **The lift of the positive one-particle comparison operator** `N₁ = −Δ + ‖x‖²/4`. -/
def qgOuterN : qgOuterCore →ₗ[ℂ] qgOuterFock := dsOp (fun n : ℕ => harmCore (d := n * 84))

theorem qgOuterN_symmetricOn : SymmetricOn qgOuterCore qgOuterN :=
  dsOp_symmetricOn _ fun _ => harmonicCore_symmetricOn

/-- **The quadratic form of a direct sum is the sum of the fibre forms**, so positivity is
fibrewise. -/
theorem dsOp_quadForm_nonneg {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
    [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)} (H : ∀ i, D i →ₗ[ℂ] G i)
    (hpos : ∀ (i : ι) (u : D i), 0 ≤ quadForm (H i) u) (x : dsCore D) :
    0 ≤ quadForm (dsOp H) x := by
  have hsum : HasSum (fun i => (inner ℂ ((x : lp G 2) i) ((dsOp H x : lp G 2) i) : ℂ))
      (inner ℂ (x : lp G 2) (dsOp H x : lp G 2)) := lp.hasSum_inner _ _
  have hre := Complex.reCLM.hasSum hsum
  refine hasSum_le (fun i => ?_) hasSum_zero hre
  exact hpos i ⟨(x : lp G 2) i, x.2.2 i⟩

/-- The lifted comparison operator has a non-negative quadratic form. -/
theorem qgOuterN_quadForm_nonneg (x : qgOuterCore) : 0 ≤ quadForm qgOuterN x :=
  dsOp_quadForm_nonneg _ (fun _ u => harmonicCore_quadForm_nonneg u) x

theorem qgOuterN_esa : EssentiallySelfAdjointOn qgOuterCore qgOuterN :=
  dsOp_essentiallySelfAdjointOn _ fun _ => harmonicCore_essentiallySelfAdjoint

end

end BookProof.QgOuterFock
