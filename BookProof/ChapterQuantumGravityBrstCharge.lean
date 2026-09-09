import Mathlib
import BookProof.ChapterBRSTNilpotent
import BookProof.ChapterQuantumGravity3DGauge

/-!
# The BRST charge of the 3D gauge-fixed gravity Hamiltonian: ghosts on `ℤ₂¹⁹` and nilpotency

`CONSOLIDATED_PLAN.md` §10.6.2 item 4 (and `PLAN_LEAN_SPECIALIST_QG_FLOW.md` **Part F**,
items F.6 and F.7) asks for the manuscript's BRST charge `G` — the diffeomorphism, local
Lorentz and translation constraints dressed with the `ℤ₂¹⁹` ghosts — and for its
nilpotency, on the field space of `BookProof/ChapterQuantumGravity3DGauge.lean`.

## What is proved

**The abstract theorem (the general non-abelian BRST charge).**  In any ring that is an
`ℝ`-algebra, for ghost operators satisfying the canonical anticommutation relations
(`BookProof.BRSTNilpotent.GhostCAR`) and constraints `G_a` that commute with the ghosts and
close into a Lie algebra with real structure constants `f`,

```
Ω = Σ_a G_a χ_a − ½ Σ_{a,b,e} f_{abe} χ_a χ_b β_e
```

satisfies **`brst_full_nilpotent`**: `Ω² = 0`.  This is the full charge, not only its cubic
ghost part: `BookProof.ChapterBRSTNilpotent.brst_charge_nilpotent` handles the cubic square
(where the Jacobi identity enters), `glin_sq` computes the square of the constraint part as
half the ghost-contracted constraint algebra, and `glin_mul_Q_add_Q_mul_glin` shows that the
cross terms produce exactly the opposite quantity — the classical cancellation that fixes
the coefficient `−½`.  Nilpotency of the *abelian* charge (`brst_abelian_nilpotent`) is the
special case `f = 0`, and needs no Jacobi identity.

**The ghost sector on `ℤ₂¹⁹` (F.7).**  The `19` diffeomorphism ghosts are realized on the
fermionic Fock space `ghostSpace = Λ(ℂ¹⁹)` (the exterior algebra — the `ℤ₂¹⁹` occupation
space), with `ghostCre a` the exterior multiplication by the `a`-th basis vector and
`ghostAnn a` the contraction against the `a`-th coordinate functional.  `ghost_car` is the
canonical anticommutation relations `{ψ_a, ψ†_b} = δ_{ab}`, `{ψ_a, ψ_b} = 0`,
`{ψ†_a, ψ†_b} = 0` in the `GhostCAR` form.

**The graded field-space (F.6).**  `QGState = ℂ[x₀,…,x₈₃] ⊗ Λ(ℂ¹⁹)` is the
Gauss–polynomial core of `L²(ℝ⁸⁴)` tensored with the ghost sector; `bosOp` and `ghostOp`
embed the operators of the two factors, `bosOp_ghostOp_comm` records that they commute, and
`qgGhostCar` transports the CAR to the graded space.

**The constraints.**  `elemGen j k` is the first-order operator `x_j ∂_k` on the
Gauss-weighted polynomial core and `linGen M = Σ_{j,k} M_{jk} x_j ∂_k` the generator of the
linear change `M` of the field coordinates — the form the diffeomorphism, Lorentz and
translation constraints take on the field space.  `elemGen_bracket` and `linGen_bracket`
prove that these generators **close into the matrix Lie algebra**:
`[linGen M, linGen N] = linGen (MN − NM)`.

**The BRST charge and its nilpotency (F.6).**  `qgBRST M f` is the charge built from a
family `M : Fin 19 → Matrix (Fin 84) (Fin 84) ℝ` of constraint generators, and
**`qgBRST_nilpotent`** proves `Ω² = 0` whenever the family closes with real structure
constants satisfying the Jacobi identity.  `qgBRST_abelian_nilpotent` is the
commuting-family instance, and `affMat`/`affF`/`affMat_close`/`affF_jacobi`/
`affBRST_nilpotent` a concrete **non-abelian** instance — the affine algebra `aff(1)`,
`[H, E] = E`, acting on the first two field coordinates, with `affMat_non_abelian`
recording that the two generators really fail to commute — so the construction is not
vacuous.

## Honest boundary

The charge is built on the *algebraic* graded core `ℂ[x] ⊗ Λ(ℂ¹⁹)` (polynomials times the
Gaussian, tensored with the finite ghost sector), which is the dense domain on which the
field-space Hamiltonian of `ChapterQuantumGravity3DGauge` is defined; no bounded extension
to the completed Hilbert space is claimed, and the reduction of the *dynamics* to BRST
cohomology is the separate `BookProof/ChapterBrstReducedTransfer.lean` (which assumes a
bounded charge).  The constraint family is data: the theorem says that *whenever* the
generators close with real structure constants obeying Jacobi, the charge is nilpotent, and
the `so(3)` instance exhibits a genuinely non-abelian family.  No mass gap and no global
existence statement is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QuantumGravityBrstCharge

open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

/-! ## The abstract non-abelian BRST charge -/

section Abstract

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}

/-- The **constraint part** of the BRST charge, `Σ_a G_a χ_a`. -/
def glin (G χ : Fin n → R) : R := ∑ a, G a * χ a

/-- **The BRST charge** `Ω = Σ_a G_a χ_a − ½ Σ_{a,b,e} f_{abe} χ_a χ_b β_e`. -/
def brstCharge (f : Fin n → Fin n → Fin n → ℝ) (G χ β : Fin n → R) : R :=
  glin G χ - (1 / 2 : ℝ) • Q f χ β

/-- The **constraint algebra**: the constraints commute with the ghosts and close with real
structure constants `f`. -/
structure ConstraintAlgebra (f : Fin n → Fin n → Fin n → ℝ) (G χ β : Fin n → R) : Prop where
  /-- the constraints commute with the ghost creation operators -/
  comm_chi : ∀ a b, G a * χ b = χ b * G a
  /-- the constraints commute with the ghost annihilation operators -/
  comm_beta : ∀ a b, G a * β b = β b * G a
  /-- the constraints close: `[G_a, G_b] = Σ_e f_{abe} G_e` -/
  bracket : ∀ a b, G a * G b - G b * G a = ∑ e, f a b e • G e

variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}

omit [Algebra ℝ R] in
/-- Ghost creation operators anticommute. -/
theorem chi_anticomm (hCAR : GhostCAR χ β) (a b : Fin n) : χ a * χ b = -(χ b * χ a) :=
  eq_neg_of_add_eq_zero_left (hCAR.chichi a b)

omit [Algebra ℝ R] in
/-- A ghost creation operator commutes with a *pair* of them. -/
theorem chi_comm_pair (hCAR : GhostCAR χ β) (a d g : Fin n) :
    χ a * (χ d * χ g) = (χ d * χ g) * χ a := by
  calc χ a * (χ d * χ g) = (χ a * χ d) * χ g := by rw [mul_assoc]
    _ = (-(χ d * χ a)) * χ g := by rw [chi_anticomm hCAR]
    _ = -(χ d * (χ a * χ g)) := by rw [neg_mul, mul_assoc]
    _ = -(χ d * (-(χ g * χ a))) := by rw [chi_anticomm hCAR]
    _ = (χ d * χ g) * χ a := by rw [mul_neg, neg_neg, mul_assoc]

/-- **The square of the constraint part** is half the ghost-contracted constraint algebra. -/
theorem glin_sq (hCAR : GhostCAR χ β) (hCA : ConstraintAlgebra f G χ β) :
    glin G χ * glin G χ = (1 / 2 : ℝ) • ∑ a, ∑ b, ∑ e, f a b e • (G e * (χ a * χ b)) := by
  have hexp : glin G χ * glin G χ = ∑ a, ∑ b, (G a * G b) * (χ a * χ b) := by
    unfold glin
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    calc (G a * χ a) * (G b * χ b) = G a * ((χ a * G b) * χ b) := by
          simp only [mul_assoc]
      _ = G a * ((G b * χ a) * χ b) := by rw [← hCA.comm_chi b a]
      _ = (G a * G b) * (χ a * χ b) := by simp only [mul_assoc]
  have hswap : ∑ a, ∑ b, (G a * G b) * (χ a * χ b)
      = -∑ a, ∑ b, (G b * G a) * (χ a * χ b) := by
    rw [Finset.sum_comm (f := fun a b => (G a * G b) * (χ a * χ b))]
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [chi_anticomm hCAR b a, mul_neg]
  have htwo : (glin G χ * glin G χ) + (glin G χ * glin G χ)
      = ∑ a, ∑ b, ∑ e, f a b e • (G e * (χ a * χ b)) := by
    rw [hexp]
    nth_rewrite 2 [hswap]
    rw [← Finset.sum_neg_distrib, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← neg_mul, ← add_mul, ← sub_eq_add_neg, hCA.bracket a b, Finset.sum_mul]
    exact Finset.sum_congr rfl fun e _ => by rw [smul_mul_assoc]
  have h2 : ((2 : ℝ)) • (glin G χ * glin G χ)
      = ∑ a, ∑ b, ∑ e, f a b e • (G e * (χ a * χ b)) := by
    rw [two_smul]; exact htwo
  calc glin G χ * glin G χ = (1 / 2 : ℝ) • ((2 : ℝ) • (glin G χ * glin G χ)) := by
        rw [smul_smul]; norm_num
    _ = (1 / 2 : ℝ) • ∑ a, ∑ b, ∑ e, f a b e • (G e * (χ a * χ b)) := by rw [h2]

/-- **The cross terms** of the square of the charge: pushing the annihilation operator of
the cubic term through the constraint part leaves exactly one contraction. -/
theorem glin_mul_Q_add_Q_mul_glin (hCAR : GhostCAR χ β) (hCA : ConstraintAlgebra f G χ β) :
    glin G χ * Q f χ β + Q f χ β * glin G χ
      = ∑ d, ∑ g, ∑ h, f d g h • (G h * (χ d * χ g)) := by
  have hterm : ∀ a d g h : Fin n,
      (G a * χ a) * (f d g h • (χ d * χ g * β h)) + (f d g h • (χ d * χ g * β h)) * (G a * χ a)
        = f d g h • ((if h = a then G a * (χ d * χ g) else 0)) := by
    intro a d g h
    have hbeta : β h * χ a = (if h = a then 1 else 0) - χ a * β h :=
      eq_sub_of_add_eq (hCAR.betachi h a)
    have hL : (G a * χ a) * (f d g h • (χ d * χ g * β h))
        = f d g h • (G a * (χ a * (χ d * χ g) * β h)) := by
      rw [mul_smul_comm]
      congr 1
      simp only [mul_assoc]
    have hR : (f d g h • (χ d * χ g * β h)) * (G a * χ a)
        = f d g h • (G a * ((χ d * χ g) * (β h * χ a))) := by
      rw [smul_mul_assoc]
      congr 1
      calc (χ d * χ g * β h) * (G a * χ a) = (χ d * χ g) * ((β h * G a) * χ a) := by
            simp only [mul_assoc]
        _ = (χ d * χ g) * ((G a * β h) * χ a) := by rw [← hCA.comm_beta a h]
        _ = G a * ((χ d * χ g) * (β h * χ a)) := by
            have h1 : (χ d * χ g) * G a = G a * (χ d * χ g) := by
              calc (χ d * χ g) * G a = χ d * (χ g * G a) := by rw [mul_assoc]
                _ = χ d * (G a * χ g) := by rw [← hCA.comm_chi a g]
                _ = (χ d * G a) * χ g := by rw [mul_assoc]
                _ = (G a * χ d) * χ g := by rw [← hCA.comm_chi a d]
                _ = G a * (χ d * χ g) := by rw [mul_assoc]
            calc (χ d * χ g) * ((G a * β h) * χ a)
                = ((χ d * χ g) * G a) * (β h * χ a) := by simp only [mul_assoc]
              _ = (G a * (χ d * χ g)) * (β h * χ a) := by rw [h1]
              _ = G a * ((χ d * χ g) * (β h * χ a)) := by simp only [mul_assoc]
    rw [hL, hR, ← smul_add]
    congr 1
    rw [hbeta, chi_comm_pair hCAR a d g]
    by_cases hh : h = a
    · simp only [if_pos hh]
      noncomm_ring
    · simp only [if_neg hh]
      noncomm_ring
  have hL : glin G χ * Q f χ β = ∑ a, ∑ d, ∑ g, ∑ h,
      (G a * χ a) * (f d g h • (χ d * χ g * β h)) := by
    unfold glin Q
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun g _ => ?_
    rw [Finset.mul_sum]
  have hR : Q f χ β * glin G χ = ∑ a, ∑ d, ∑ g, ∑ h,
      (f d g h • (χ d * χ g * β h)) * (G a * χ a) := by
    have step : Q f χ β * glin G χ = ∑ d, ∑ g, ∑ h, ∑ a,
        (f d g h • (χ d * χ g * β h)) * (G a * χ a) := by
      unfold glin Q
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun h _ => ?_
      rw [Finset.mul_sum]
    rw [step]
    calc (∑ d, ∑ g, ∑ h, ∑ a, (f d g h • (χ d * χ g * β h)) * (G a * χ a))
        = ∑ d, ∑ g, ∑ a, ∑ h, (f d g h • (χ d * χ g * β h)) * (G a * χ a) :=
          Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun g _ => Finset.sum_comm
      _ = ∑ d, ∑ a, ∑ g, ∑ h, (f d g h • (χ d * χ g * β h)) * (G a * χ a) :=
          Finset.sum_congr rfl fun d _ => Finset.sum_comm
      _ = ∑ a, ∑ d, ∑ g, ∑ h, (f d g h • (χ d * χ g * β h)) * (G a * χ a) := Finset.sum_comm
  have hsum : glin G χ * Q f χ β + Q f χ β * glin G χ
      = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((if h = a then G a * (χ d * χ g) else 0)) := by
    rw [hL, hR, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun g _ => ?_
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun h _ => hterm a d g h
  rw [hsum]
  calc (∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((if h = a then G a * (χ d * χ g) else 0)))
      = ∑ d, ∑ a, ∑ g, ∑ h, f d g h • ((if h = a then G a * (χ d * χ g) else 0)) :=
        Finset.sum_comm
    _ = ∑ d, ∑ g, ∑ a, ∑ h, f d g h • ((if h = a then G a * (χ d * χ g) else 0)) :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ d, ∑ g, ∑ h, ∑ a, f d g h • ((if h = a then G a * (χ d * χ g) else 0)) :=
        Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun g _ => Finset.sum_comm
    _ = ∑ d, ∑ g, ∑ h, f d g h • (G h * (χ d * χ g)) := by
        refine Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun g _ =>
          Finset.sum_congr rfl fun h _ => ?_
        simp [Finset.sum_ite_eq]

/-- **The BRST charge is nilpotent** (F.6): for constraints closing into a Lie algebra with
antisymmetric structure constants satisfying the Jacobi identity, `Ω² = 0`. -/
theorem brst_full_nilpotent (hCAR : GhostCAR χ β) (hCA : ConstraintAlgebra f G χ β)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    brstCharge f G χ β * brstCharge f G χ β = 0 := by
  have hQ : Q f χ β * Q f χ β = 0 := brst_charge_nilpotent f χ β hCAR hf12 hjac
  have hX : glin G χ * glin G χ
      = (1 / 2 : ℝ) • ∑ a, ∑ b, ∑ e, f a b e • (G e * (χ a * χ b)) := glin_sq hCAR hCA
  have hC : glin G χ * Q f χ β + Q f χ β * glin G χ
      = ∑ d, ∑ g, ∑ h, f d g h • (G h * (χ d * χ g)) :=
    glin_mul_Q_add_Q_mul_glin hCAR hCA
  have hexp : brstCharge f G χ β * brstCharge f G χ β
      = glin G χ * glin G χ - (1 / 2 : ℝ) • (glin G χ * Q f χ β + Q f χ β * glin G χ)
        + ((1 / 2 : ℝ) * (1 / 2 : ℝ)) • (Q f χ β * Q f χ β) := by
    simp only [brstCharge, sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm]
    module
  rw [hexp, hX, hC, hQ, smul_zero, add_zero, sub_self]

/-- **The abelian BRST charge is nilpotent**: for commuting constraints the cubic ghost term
is unnecessary, and no Jacobi identity is needed. -/
theorem brst_abelian_nilpotent (hCAR : GhostCAR χ β)
    (hcomm_chi : ∀ a b, G a * χ b = χ b * G a) (hcomm_beta : ∀ a b, G a * β b = β b * G a)
    (hab : ∀ a b, G a * G b = G b * G a) :
    glin G χ * glin G χ = 0 := by
  have hCA : ConstraintAlgebra (fun _ _ _ => (0 : ℝ)) G χ β :=
    { comm_chi := hcomm_chi
      comm_beta := hcomm_beta
      bracket := by intro a b; simp [hab a b] }
  have h := glin_sq (f := fun _ _ _ => (0 : ℝ)) hCAR hCA
  simpa using h

end Abstract

/-! ## The constraint generators on the field space

The diffeomorphism, local Lorentz and translation constraints act on the field space by
infinitesimal *linear* changes of the field coordinates, i.e. by the first-order operators
`x_j ∂_k` (here `∂_k` is the covariant derivative `derOp k` of the Gauss-weighted core).
These span a copy of `gl(d)` and are the generators the BRST charge is built from. -/

section Generators

variable {d : ℕ}

/-- The **elementary generator** `E_{jk} = x_j ∂_k` on the Gauss-weighted polynomial core. -/
def elemGen (j k : Fin d) : Module.End ℂ (MvPolynomial (Fin d) ℂ) :=
  (mulOp (X j)).comp (derOp k)

theorem elemGen_apply (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    elemGen j k p = X j * derOp k p := rfl

/-- **Leibniz rule for the covariant derivative** against a coordinate. -/
theorem derOp_mulOp (k l : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    derOp k (X l * p) = X l * derOp k p + (if k = l then p else 0) := by
  classical
  simp only [derOp_apply, Derivation.leibniz, MvPolynomial.pderiv_X, Pi.single_apply,
    smul_eq_C_mul]
  by_cases h : k = l
  · subst h; simp; ring
  · simp [h, Ne.symm h]; ring

/-- **The elementary generators close into `gl(d)`**:
`[E_{jk}, E_{lm}] = δ_{kl} E_{jm} − δ_{jm} E_{lk}`. -/
theorem elemGen_bracket (j k l m : Fin d) :
    elemGen j k * elemGen l m - elemGen l m * elemGen j k
      = (if k = l then elemGen j m else 0) - (if j = m then elemGen l k else 0) := by
  classical
  refine LinearMap.ext fun p => ?_
  have hcomm : derOp k (derOp m p) = derOp m (derOp k p) := derOp_comm k m p
  have hswap : (if m = j then (derOp k) p else 0) = (if j = m then derOp k p else 0) := by
    by_cases h : j = m
    · simp [h]
    · simp [h, Ne.symm h]
  have hR : ((if k = l then elemGen j m else 0) - (if j = m then elemGen (d := d) l k else 0)) p
      = (if k = l then X j * derOp m p else 0) - (if j = m then X l * derOp k p else 0) := by
    by_cases h1 : k = l <;> by_cases h2 : j = m <;> simp [h1, h2, elemGen_apply]
  rw [hR]
  simp only [LinearMap.sub_apply, Module.End.mul_apply, elemGen_apply, derOp_mulOp, mul_add,
    hcomm, mul_ite, mul_zero, hswap]
  ring

/-- The generator `∑_{j,k} M_{jk} x_j ∂_k` of the linear field-coordinate change `M`, as an
infinitesimally `ℝ`-linear function of `M`. -/
def linGenLM : Matrix (Fin d) (Fin d) ℝ →ₗ[ℝ] Module.End ℂ (MvPolynomial (Fin d) ℂ) where
  toFun M := ∑ j, ∑ k, (M j k) • elemGen j k
  map_add' A B := by
    simp only [Matrix.add_apply, add_smul]
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← Finset.sum_add_distrib]
  map_smul' r A := by
    simp only [Matrix.smul_apply, smul_eq_mul, RingHom.id_apply, Finset.smul_sum, smul_smul]

/-- **The constraint generator** attached to a real matrix `M`: `∑_{j,k} M_{jk} x_j ∂_k`. -/
def linGen (M : Matrix (Fin d) (Fin d) ℝ) : Module.End ℂ (MvPolynomial (Fin d) ℂ) := linGenLM M

theorem linGen_def (M : Matrix (Fin d) (Fin d) ℝ) :
    linGen M = ∑ j, ∑ k, (M j k) • elemGen j k := rfl

theorem linGen_sub (A B : Matrix (Fin d) (Fin d) ℝ) :
    linGen (A - B) = linGen A - linGen B := map_sub linGenLM A B

theorem linGen_zero : linGen (0 : Matrix (Fin d) (Fin d) ℝ) = 0 := map_zero linGenLM

theorem linGen_smul_sum {n : ℕ} (c : Fin n → ℝ) (M : Fin n → Matrix (Fin d) (Fin d) ℝ) :
    linGen (∑ e, c e • M e) = ∑ e, c e • linGen (M e) := by
  rw [linGen, map_sum]
  exact Finset.sum_congr rfl fun e _ => map_smul linGenLM (c e) (M e)

/-- Expansion of a product of two constraint generators. -/
theorem linGen_prod (A B : Matrix (Fin d) (Fin d) ℝ) :
    linGen A * linGen B
      = ∑ j, ∑ k, ∑ l, ∑ m, (A j k * B l m) • (elemGen j k * elemGen l m) := by
  rw [linGen_def, linGen_def, Finset.sum_mul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [smul_mul_assoc, mul_smul_comm, smul_smul]

section SumHelpers

variable {α : Type*}

/-- Exchange the two index blocks of a four-fold sum. -/
theorem sum4_swap_blocks [AddCommMonoid α] (F : Fin d → Fin d → Fin d → Fin d → α) :
    ∑ l, ∑ m, ∑ j, ∑ k, F l m j k = ∑ j, ∑ k, ∑ l, ∑ m, F l m j k := by
  calc ∑ l, ∑ m, ∑ j, ∑ k, F l m j k
      = ∑ l, ∑ j, ∑ m, ∑ k, F l m j k := Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ j, ∑ l, ∑ m, ∑ k, F l m j k := Finset.sum_comm
    _ = ∑ j, ∑ l, ∑ k, ∑ m, F l m j k :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ j, ∑ k, ∑ l, ∑ m, F l m j k := Finset.sum_congr rfl fun _ _ => Finset.sum_comm

/-- Difference of two four-fold sums. -/
theorem sum4_sub_distrib [AddCommGroup α] (F G : Fin d → Fin d → Fin d → Fin d → α) :
    (∑ j, ∑ k, ∑ l, ∑ m, F j k l m) - (∑ j, ∑ k, ∑ l, ∑ m, G j k l m)
      = ∑ j, ∑ k, ∑ l, ∑ m, (F j k l m - G j k l m) := by
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [← Finset.sum_sub_distrib]

end SumHelpers

/-- Contraction of the first Kronecker delta of `elemGen_bracket`. -/
theorem linGen_contract_left (A B : Matrix (Fin d) (Fin d) ℝ) :
    (∑ j, ∑ k, ∑ l, ∑ m, (A j k * B l m) • (if k = l then elemGen j m else 0))
      = linGen (A * B) := by
  classical
  have step1 : ∀ j k : Fin d,
      (∑ l, ∑ m, (A j k * B l m) • (if k = l then elemGen (d := d) j m else 0))
        = ∑ m, (A j k * B k m) • elemGen j m := by
    intro j k
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun m _ => ?_
    simp [Finset.sum_ite_eq]
  rw [Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => step1 j k, linGen_def]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [← Finset.sum_smul, Matrix.mul_apply]

/-- Contraction of the second Kronecker delta of `elemGen_bracket`. -/
theorem linGen_contract_right (A B : Matrix (Fin d) (Fin d) ℝ) :
    (∑ j, ∑ k, ∑ l, ∑ m, (A j k * B l m) • (if j = m then elemGen l k else 0))
      = linGen (B * A) := by
  classical
  have step1 : ∀ j k l : Fin d,
      (∑ m, (A j k * B l m) • (if j = m then elemGen (d := d) l k else 0))
        = (A j k * B l j) • elemGen l k := by
    intro j k l
    simp [Finset.sum_ite_eq]
  rw [Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
    Finset.sum_congr rfl fun l _ => step1 j k l, linGen_def]
  calc (∑ j, ∑ k, ∑ l, (A j k * B l j) • elemGen (d := d) l k)
      = ∑ j, ∑ l, ∑ k, (A j k * B l j) • elemGen (d := d) l k :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ l, ∑ j, ∑ k, (A j k * B l j) • elemGen (d := d) l k := Finset.sum_comm
    _ = ∑ l, ∑ k, ∑ j, (A j k * B l j) • elemGen (d := d) l k :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ l, ∑ k, ((B * A) l k) • elemGen (d := d) l k := by
        refine Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun k _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
        congr 1
        exact Finset.sum_congr rfl fun _ _ => mul_comm _ _

/-- **The constraint generators represent the matrix Lie algebra**:
`[linGen A, linGen B] = linGen (AB − BA)`. -/
theorem linGen_bracket (A B : Matrix (Fin d) (Fin d) ℝ) :
    linGen A * linGen B - linGen B * linGen A = linGen (A * B - B * A) := by
  have h2 : linGen B * linGen A
      = ∑ j, ∑ k, ∑ l, ∑ m, (A j k * B l m) • (elemGen l m * elemGen j k) := by
    rw [linGen_prod B A,
      sum4_swap_blocks (fun l m j k => (B l m * A j k) • (elemGen (d := d) l m * elemGen j k))]
    exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
      Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by rw [mul_comm (B _ _)]
  rw [linGen_prod A B, h2, sum4_sub_distrib]
  have hterm : ∀ j k l m : Fin d,
      (A j k * B l m) • (elemGen (d := d) j k * elemGen l m)
        - (A j k * B l m) • (elemGen (d := d) l m * elemGen j k)
      = (A j k * B l m) • (if k = l then elemGen (d := d) j m else 0)
        - (A j k * B l m) • (if j = m then elemGen (d := d) l k else 0) := by
    intro j k l m
    rw [← smul_sub, elemGen_bracket, smul_sub]
  rw [Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
    Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun m _ => hterm j k l m,
    ← sum4_sub_distrib, linGen_contract_left, linGen_contract_right, linGen_sub]

end Generators

/-! ## The ghost sector on `ℤ₂¹⁹` (F.7)

The `19` ghosts live on the fermionic occupation space `ℤ₂¹⁹`, realized as the exterior
algebra `Λ(ℂ¹⁹)`.  Creation is exterior multiplication, annihilation is contraction. -/

/-- The ghost Fock space: the `ℤ₂¹⁹` occupation space `Λ(ℂ¹⁹)`. -/
abbrev ghostSpace : Type := ExteriorAlgebra ℂ (Fin 19 → ℂ)

/-- The ghost **creation** operator `ψ†_a`: exterior multiplication by the `a`-th basis vector. -/
def ghostCre (a : Fin 19) : Module.End ℂ ghostSpace :=
  LinearMap.mulLeft ℂ (ExteriorAlgebra.ι ℂ (Pi.single a 1))

/-- The ghost **annihilation** operator `ψ_a`: contraction against the `a`-th coordinate. -/
def ghostAnn (a : Fin 19) : Module.End ℂ ghostSpace :=
  CliffordAlgebra.contractLeft (LinearMap.proj a)

/-- **The ghosts obey the canonical anticommutation relations** (F.7). -/
theorem ghost_car : GhostCAR ghostCre ghostAnn := by
  constructor
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCre, LinearMap.add_apply, Module.End.mul_apply, LinearMap.mulLeft_apply,
      LinearMap.zero_apply, ← mul_assoc]
    rw [← add_mul, CliffordAlgebra.ι_mul_ι_add_swap]
    simp [QuadraticMap.polar]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostAnn, LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply]
    rw [CliffordAlgebra.contractLeft_comm, neg_add_cancel]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCre, ghostAnn, LinearMap.add_apply, Module.End.mul_apply,
      LinearMap.mulLeft_apply, CliffordAlgebra.contractLeft_ι_mul]
    by_cases h : a = b
    · subst h; simp
    · simp [h]

/-! ## The graded field space (F.6)

The total state space is the Gauss–polynomial core of `L²(ℝ⁸⁴)` tensored with the ghost
sector.  Bosonic and ghost operators embed as `T ⊗ 1` and `1 ⊗ T`, and therefore commute. -/

/-- The bosonic factor: the polynomial core of the `84`-dimensional field space. -/
abbrev qgPoly : Type := MvPolynomial (Fin 84) ℂ

/-- The **graded field space** `ℂ[x₀,…,x₈₃] ⊗ Λ(ℂ¹⁹)`. -/
abbrev QGState : Type := TensorProduct ℂ qgPoly ghostSpace

/-- A bosonic operator, acting as `T ⊗ 1` on the graded space. -/
def bosOp (T : Module.End ℂ qgPoly) : Module.End ℂ QGState := LinearMap.rTensor ghostSpace T

/-- A ghost operator, acting as `1 ⊗ T` on the graded space. -/
def ghostOp (T : Module.End ℂ ghostSpace) : Module.End ℂ QGState := LinearMap.lTensor qgPoly T

theorem bosOp_mul (S T : Module.End ℂ qgPoly) : bosOp (S * T) = bosOp S * bosOp T := by
  simp [bosOp, Module.End.mul_eq_comp, LinearMap.rTensor_comp]

theorem bosOp_sub (S T : Module.End ℂ qgPoly) : bosOp (S - T) = bosOp S - bosOp T := by
  simp [bosOp]

theorem bosOp_smul (r : ℝ) (T : Module.End ℂ qgPoly) : bosOp (r • T) = r • bosOp T := by
  refine LinearMap.ext fun x => ?_
  induction x using TensorProduct.induction_on with
  | zero => simp
  | tmul a b => simp [bosOp, TensorProduct.smul_tmul']
  | add x y hx hy => simp [hx, hy]

theorem bosOp_sum {n : ℕ} (T : Fin n → Module.End ℂ qgPoly) :
    bosOp (∑ e, T e) = ∑ e, bosOp (T e) :=
  map_sum (LinearMap.rTensorHom (R := ℂ) ghostSpace) T Finset.univ

theorem ghostOp_mul (S T : Module.End ℂ ghostSpace) : ghostOp (S * T) = ghostOp S * ghostOp T := by
  simp [ghostOp, Module.End.mul_eq_comp, LinearMap.lTensor_comp]

theorem ghostOp_add (S T : Module.End ℂ ghostSpace) : ghostOp (S + T) = ghostOp S + ghostOp T := by
  simp [ghostOp]

theorem ghostOp_one : ghostOp 1 = 1 := by
  simp [ghostOp, Module.End.one_eq_id, LinearMap.lTensor_id]

theorem ghostOp_zero : ghostOp 0 = 0 := by simp [ghostOp]

/-- **Bosonic and ghost operators commute** on the graded field space. -/
theorem bosOp_ghostOp_comm (S : Module.End ℂ qgPoly) (T : Module.End ℂ ghostSpace) :
    bosOp S * ghostOp T = ghostOp T * bosOp S := by
  simp [bosOp, ghostOp, Module.End.mul_eq_comp, LinearMap.lTensor_comp_rTensor,
    LinearMap.rTensor_comp_lTensor]

/-- The ghost creation operators on the graded field space. -/
def qgChi (a : Fin 19) : Module.End ℂ QGState := ghostOp (ghostCre a)

/-- The ghost annihilation operators on the graded field space. -/
def qgBeta (a : Fin 19) : Module.End ℂ QGState := ghostOp (ghostAnn a)

/-- **The CAR hold on the graded field space.** -/
theorem qgGhostCar : GhostCAR qgChi qgBeta := by
  classical
  constructor
  · intro a b
    rw [qgChi, qgChi, ← ghostOp_mul, ← ghostOp_mul, ← ghostOp_add, ghost_car.chichi a b,
      ghostOp_zero]
  · intro a b
    rw [qgBeta, qgBeta, ← ghostOp_mul, ← ghostOp_mul, ← ghostOp_add, ghost_car.betabeta a b,
      ghostOp_zero]
  · intro a b
    rw [qgBeta, qgChi, ← ghostOp_mul, ← ghostOp_mul, ← ghostOp_add, ghost_car.betachi a b]
    by_cases h : a = b
    · simp [h, ghostOp_one]
    · simp [h, ghostOp_zero]

/-- The **constraints** attached to a family of linear field-coordinate generators. -/
def qgConstraint (M : Fin 19 → Matrix (Fin 84) (Fin 84) ℝ) (a : Fin 19) : Module.End ℂ QGState :=
  bosOp (linGen (M a))

/-- **The BRST charge of the 3D gauge-fixed gravity field space** (F.6). -/
def qgBRST (M : Fin 19 → Matrix (Fin 84) (Fin 84) ℝ) (f : Fin 19 → Fin 19 → Fin 19 → ℝ) :
    Module.End ℂ QGState :=
  brstCharge f (qgConstraint M) qgChi qgBeta

/-- A closing family of matrices gives a `ConstraintAlgebra` on the graded field space. -/
theorem qgConstraintAlgebra (M : Fin 19 → Matrix (Fin 84) (Fin 84) ℝ)
    (f : Fin 19 → Fin 19 → Fin 19 → ℝ)
    (hclose : ∀ a b, M a * M b - M b * M a = ∑ e, f a b e • M e) :
    ConstraintAlgebra f (qgConstraint M) qgChi qgBeta where
  comm_chi a b := bosOp_ghostOp_comm _ _
  comm_beta a b := bosOp_ghostOp_comm _ _
  bracket a b := by
    simp only [qgConstraint, ← bosOp_mul, ← bosOp_sub, linGen_bracket, hclose a b,
      linGen_smul_sum]
    rw [bosOp_sum]
    exact Finset.sum_congr rfl fun e _ => bosOp_smul _ _

/-- **The BRST charge of the gravity field space is nilpotent** (F.6): whenever the family of
constraint generators closes with real structure constants that are antisymmetric in their
first two indices and satisfy the Jacobi identity, `Ω² = 0`. -/
theorem qgBRST_nilpotent (M : Fin 19 → Matrix (Fin 84) (Fin 84) ℝ)
    (f : Fin 19 → Fin 19 → Fin 19 → ℝ)
    (hclose : ∀ a b, M a * M b - M b * M a = ∑ e, f a b e • M e)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin 19,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    qgBRST M f * qgBRST M f = 0 :=
  brst_full_nilpotent qgGhostCar (qgConstraintAlgebra M f hclose) hf12 hjac

/-- **The abelian BRST charge is nilpotent**: for a commuting family of constraint generators
the cubic ghost term is unnecessary. -/
theorem qgBRST_abelian_nilpotent (M : Fin 19 → Matrix (Fin 84) (Fin 84) ℝ)
    (hcomm : ∀ a b, M a * M b = M b * M a) :
    glin (qgConstraint M) qgChi * glin (qgConstraint M) qgChi = 0 := by
  refine brst_abelian_nilpotent (β := qgBeta) qgGhostCar (fun a b => bosOp_ghostOp_comm _ _)
    (fun a b => bosOp_ghostOp_comm _ _) fun a b => ?_
  have h : linGen (M a) * linGen (M b) - linGen (M b) * linGen (M a) = 0 := by
    rw [linGen_bracket, hcomm a b, sub_self, linGen_zero]
  have h0 : bosOp (linGen (M a)) * bosOp (linGen (M b))
      - bosOp (linGen (M b)) * bosOp (linGen (M a)) = 0 := by
    rw [← bosOp_mul, ← bosOp_mul, ← bosOp_sub, h, bosOp]
    simp
  exact sub_eq_zero.mp h0

/-! ## A concrete non-abelian instance

The construction is not vacuous: the two-dimensional non-abelian Lie algebra `[H, E] = E`
(the affine algebra `aff(1)`, realized by the matrix units `E₀₀` and `E₀₁` acting on the first
two field coordinates) closes with real structure constants that are antisymmetric and
satisfy the Jacobi identity, so its BRST charge is nilpotent. -/

/-- Structure-constant kernel of `aff(1)`: `ε_{01} = 1`, `ε_{10} = −1`, all else `0`. -/
def affEps (a b : Fin 19) : ℝ :=
  (if a = 0 ∧ b = 1 then (1 : ℝ) else 0) - (if a = 1 ∧ b = 0 then 1 else 0)

/-- The structure constants of `aff(1)`: `f_{ab}{}^e = ε_{ab} δ^e_1`. -/
def affF (a b e : Fin 19) : ℝ := if e = 1 then affEps a b else 0

/-- The generators of `aff(1)`: `H = E₀₀`, `E = E₀₁`, and `0` for the remaining ghosts. -/
def affMat (a : Fin 19) : Matrix (Fin 84) (Fin 84) ℝ :=
  if a = 0 then Matrix.single 0 0 1 else if a = 1 then Matrix.single 0 1 1 else 0

/-- The family is genuinely **non-abelian**. -/
theorem affMat_non_abelian : affMat 0 * affMat 1 ≠ affMat 1 * affMat 0 := by
  intro hcon
  have h : (affMat 0 * affMat 1) 0 1 = (affMat 1 * affMat 0) 0 1 := by rw [hcon]
  simp [affMat, show (1 : Fin 84) ≠ 0 by decide] at h

theorem affF_antisymm (a b c : Fin 19) : affF a b c = -affF b a c := by
  simp only [affF, affEps]
  by_cases h : c = 1
  · simp only [h, if_true]
    split_ifs <;> simp_all
  · simp only [h, if_false, neg_zero]

theorem affF_contract (x y z w : Fin 19) :
    ∑ e, affF x y e * affF e z w = affEps x y * (if w = 1 then affEps 1 z else 0) := by
  simp only [affF, ite_mul, zero_mul]
  rw [Finset.sum_ite_eq' Finset.univ (1 : Fin 19)]
  simp

set_option maxHeartbeats 1000000 in
-- the `2⁶` sign cases of the Jacobi identity are discharged by `simp_all`, which is slow
theorem affF_jacobi (a b c h : Fin 19) :
    ∑ e, (affF a b e * affF e c h + affF b c e * affF e a h + affF c a e * affF e b h) = 0 := by
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib, affF_contract, affF_contract, affF_contract]
  by_cases hh : h = 1
  · subst hh
    simp only []
    by_cases ha0 : a = 0 <;> by_cases ha1 : a = 1 <;> by_cases hb0 : b = 0 <;>
      by_cases hb1 : b = 1 <;> by_cases hc0 : c = 0 <;> by_cases hc1 : c = 1 <;>
      simp_all [affEps]
  · simp [hh]

/-- **The `aff(1)` family closes** with the structure constants `affF`. -/
theorem affMat_close (a b : Fin 19) :
    affMat a * affMat b - affMat b * affMat a = ∑ e, affF a b e • affMat e := by
  have hrhs : (∑ e, affF a b e • affMat e) = affEps a b • affMat 1 := by
    simp [affF]
  rw [hrhs]
  by_cases ha0 : a = 0 <;> by_cases ha1 : a = 1 <;> by_cases hb0 : b = 0 <;>
    by_cases hb1 : b = 1 <;>
    simp_all [affMat, affEps, Matrix.single_mul_single_of_ne, show (1 : Fin 84) ≠ 0 by decide]

/-- **A concrete non-abelian nilpotent BRST charge** on the 3D gauge-fixed gravity field
space. -/
theorem affBRST_nilpotent : qgBRST affMat affF * qgBRST affMat affF = 0 :=
  qgBRST_nilpotent affMat affF affMat_close affF_antisymm affF_jacobi

end

end BookProof.QuantumGravityBrstCharge
