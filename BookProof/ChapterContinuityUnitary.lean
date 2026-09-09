import Mathlib
import BookProof.ChapterTrajectory

/-!
# The dynamics-based ("less arbitrary") unitary

Source: the manuscript's field-theoretic thread (`QFM.tex`) and the
`ConditionalUnitary` chapter's *"A Less Arbitrary Construction"* section
(`Book/ConditionalUnitary.lean`); proof plan appendix §E
(`Book/ProofPlans.lean`).

`BookProof.ChapterJointUnitary` builds the unitary parametrizing a conditional
probability by *Gram–Schmidt completion* of the wave-function `Ψ = √p`.  That
construction is correct but arbitrary: the columns after the first are chosen by
the completion.  The alternative developed here fixes the unitary by the
*dynamics*: a velocity field `v` on a finite (cyclic) lattice determines a
Weyl-symmetrized Hermitian generator

  `H = ½ (p·v + v·p)`,

and hence a one-parameter unitary group `U t = exp (i t H)`.  The conditional
probability is then recovered by the ordinary Born rule.

We work on the finite lattice `ZMod N` (the discretization used throughout
`BookProof`), with the symmetric-difference momentum
`(p ψ) k = -(i/2) (ψ (k+1) - ψ (k-1))`.

Main results:

* `momentum_hermitian`, `velocityOp_hermitian`,
  `continuityHamiltonian_hermitian` — the Weyl-symmetrized generator is
  Hermitian, while `momentum_mul_velocityOp_not_hermitian` shows the
  unsymmetrized `p·v` is not — the symmetrization is what makes the generator a
  legitimate observable;
* `continuityUnitary_unitary` — `U t = exp (i t H)` is unitary, together with
  `continuityUnitary_zero` and `continuityUnitary_add` (a one-parameter group);
* `bornRecover_nonneg`, `bornRecover_empty`, `bornRecover_union`,
  `bornRecover_univ` — the Born rule applied to the evolved state defines a
  finitely additive probability law on the lattice, for each input;
* `bornPMF` / `condProb_of_continuity` — the capstone: for a family of velocity
  fields indexed by the inputs `x` and a normalized initial state, the Born
  weights form a genuine probability distribution for every `x` (a Markov
  kernel / regular conditional probability in the finite setting), whose mass on
  a set `B` is exactly `bornRecover`;
* `tensorIsom` / `tensorIsom_tmul` — the finite index-level tensor–product
  identification `L²(X) ⊗ L²(Z) ≅ L²(X × Z)` that lets the construction run on
  the scalar space with no Bochner machinery, and
  `bornRecover_product_state` — the Born recovery for a product initial state
  `Ψ₀(x, z) = f(x) e₀(z)` with `|f x| = 1`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators Matrix TensorProduct

namespace BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]

/-! ## The Weyl-symmetrized continuity generator -/

/-- The discrete momentum operator on the cyclic lattice `ZMod N`:
`(p ψ) k = -(i/2) (ψ (k+1) - ψ (k-1))`. -/
noncomputable def momentum (N : ℕ) [NeZero N] : Matrix (ZMod N) (ZMod N) ℂ :=
  fun k j => (if j = k + 1 then -Complex.I / 2 else 0)
           + (if j = k - 1 then Complex.I / 2 else 0)

/-- The multiplication ("velocity field") operator of a real function `v`. -/
def velocityOp (v : ZMod N → ℝ) : Matrix (ZMod N) (ZMod N) ℂ :=
  Matrix.diagonal fun k => (v k : ℂ)

/-- The **Weyl-symmetrized continuity generator** `H = ½ (p·v + v·p)`. -/
noncomputable def continuityHamiltonian (v : ZMod N → ℝ) :
    Matrix (ZMod N) (ZMod N) ℂ :=
  (1 / 2 : ℂ) • (momentum N * velocityOp v + velocityOp v * momentum N)

theorem momentum_hermitian : (momentum N)ᴴ = momentum N := by
  ext k j
  have h1 : (k = j + 1) ↔ (j = k - 1) := ⟨fun h => by subst h; ring, fun h => by subst h; ring⟩
  have h2 : (k = j - 1) ↔ (j = k + 1) := ⟨fun h => by subst h; ring, fun h => by subst h; ring⟩
  simp only [Matrix.conjTranspose_apply, momentum, star_add, apply_ite (star : ℂ → ℂ),
    star_zero, h1, h2]
  rw [add_comm]
  congr 1 <;> simp

omit [NeZero N] in
theorem velocityOp_hermitian (v : ZMod N → ℝ) : (velocityOp v)ᴴ = velocityOp v := by
  ext k j
  by_cases h : k = j <;>
    simp [velocityOp, Matrix.conjTranspose_apply, Matrix.diagonal, h, eq_comm]

/-- **The Weyl-symmetrized generator is Hermitian.**  Neither `p·v` nor `v·p` is
Hermitian on its own; the symmetrization is exactly what repairs it. -/
theorem continuityHamiltonian_hermitian (v : ZMod N → ℝ) :
    (continuityHamiltonian v)ᴴ = continuityHamiltonian v := by
  have hp := momentum_hermitian (N := N)
  have hv := velocityOp_hermitian v
  simp only [continuityHamiltonian, Matrix.conjTranspose_smul, Matrix.conjTranspose_add,
    Matrix.conjTranspose_mul, hp, hv]
  rw [add_comm (velocityOp v * momentum N)]
  norm_num

/-- **The symmetrization is necessary.**  The unsymmetrized product `p·v` is
*not* Hermitian in general: on the three-site lattice with the velocity field
`v k = k`, the `(0,1)` entry of `(p·v)ᴴ` is `0` while that of `p·v` is `-i/2`. -/
theorem momentum_mul_velocityOp_not_hermitian :
    (momentum 3 * velocityOp (fun k => (k.val : ℝ)))ᴴ
      ≠ momentum 3 * velocityOp (fun k => (k.val : ℝ)) := by
  set M : Matrix (ZMod 3) (ZMod 3) ℂ := momentum 3 * velocityOp (fun k => (k.val : ℝ))
    with hM
  intro h
  have hne : ¬((1 : ZMod 3) = -1) := by decide
  have h01 : Mᴴ 0 1 = M 0 1 := by rw [h]
  rw [Matrix.conjTranspose_apply, hM, velocityOp, Matrix.mul_diagonal,
    Matrix.mul_diagonal] at h01
  norm_num [momentum, ZMod.val, hne] at h01
  simp [Complex.ext_iff] at h01
  norm_num at h01

/-! ## The unitary generated by a Hermitian matrix -/

/-- `exp (i t A)` is unitary for a Hermitian `A` and real `t`. -/
theorem exp_smul_I_unitary {n : Type*} [Fintype n] [DecidableEq n]
    (A : Matrix n n ℂ) (hA : Aᴴ = A) (t : ℝ) :
    (NormedSpace.exp (((t : ℂ) * Complex.I) • A))ᴴ *
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 := by
  set B : Matrix n n ℂ := ((t : ℂ) * Complex.I) • A with hB
  have hBstar : Bᴴ = -B := by
    simp only [hB, Matrix.conjTranspose_smul, hA, RCLike.star_def, map_mul,
      Complex.conj_I, Complex.conj_ofReal, neg_smul, mul_neg]
  calc (NormedSpace.exp B)ᴴ * NormedSpace.exp B
      = NormedSpace.exp Bᴴ * NormedSpace.exp B := by rw [Matrix.exp_conjTranspose]
    _ = NormedSpace.exp (-B) * NormedSpace.exp B := by rw [hBstar]
    _ = NormedSpace.exp (-B + B) := (Matrix.exp_add_of_commute _ _ (Commute.neg_left rfl)).symm
    _ = 1 := by rw [neg_add_cancel, NormedSpace.exp_zero]

/-- The **dynamics-based unitary**: `U t = exp (i t H)` for the continuity
generator `H` of the velocity field `v`.  Unlike a Gram–Schmidt completion it is
pinned down by the function `v` alone. -/
noncomputable def continuityUnitary (v : ZMod N → ℝ) (t : ℝ) :
    Matrix (ZMod N) (ZMod N) ℂ :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • continuityHamiltonian v)

/-- **`U t` is unitary** — the "function → unitary" translation. -/
theorem continuityUnitary_unitary (v : ZMod N → ℝ) (t : ℝ) :
    (continuityUnitary v t)ᴴ * continuityUnitary v t = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_hermitian v) t

theorem continuityUnitary_zero (v : ZMod N → ℝ) : continuityUnitary v 0 = 1 := by
  simp [continuityUnitary, NormedSpace.exp_zero]

/-- `U` is a one-parameter group: `U (s + t) = U s · U t`. -/
theorem continuityUnitary_add (v : ZMod N → ℝ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
      = ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, Matrix.exp_add_of_commute _ _ hcomm]
  rfl

/-! ## Born recovery of the conditional law -/

/-- The state evolved for time `t` by the dynamics-based unitary. -/
noncomputable def evolvedState (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ) :
    ZMod N → ℂ := continuityUnitary v t *ᵥ psi

/-- The Born weight of a set `B` of lattice sites in the evolved state:
`P(B) = ∑_{z ∈ B} |Ψ_t(z)|²`. -/
noncomputable def bornRecover (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (B : Finset (ZMod N)) : ℝ := ∑ z ∈ B, ‖evolvedState v t psi z‖ ^ 2

theorem bornRecover_nonneg (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (B : Finset (ZMod N)) : 0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ) :
    bornRecover v t psi ∅ = 0 := by simp [bornRecover]

/-- Finite additivity on disjoint sets. -/
theorem bornRecover_union (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    {B C : Finset (ZMod N)} (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by
  simp [bornRecover, Finset.sum_union h]

theorem bornRecover_mono (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    {B C : Finset (ZMod N)} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- A unitary matrix preserves the `ℓ²` mass of a vector. -/
theorem unitary_preserves_normSq {n : Type*} [Fintype n] [DecidableEq n]
    (U : Matrix n n ℂ) (hU : Uᴴ * U = 1) (psi : n → ℂ) :
    ∑ a, ‖(U *ᵥ psi) a‖ ^ 2 = ∑ a, ‖psi a‖ ^ 2 := by
  have expand : ∀ v : n → ℂ, (star v ⬝ᵥ v) = ((∑ a, ‖v a‖ ^ 2 : ℝ) : ℂ) := by
    intro v
    simp [dotProduct, Complex.conj_mul']
  have key : (star (U *ᵥ psi)) ⬝ᵥ (U *ᵥ psi) = (star psi) ⬝ᵥ psi := by
    rw [Matrix.dotProduct_mulVec, Matrix.star_mulVec, Matrix.vecMul_vecMul, hU,
      Matrix.vecMul_one]
  rw [expand, expand] at key
  exact_mod_cast key

/-- **Born recovery: the total mass is `1`.**  Unitarity of the dynamics-based
`U t` turns a normalized initial state into a normalized evolved state, so the
Born weights are a probability law on the lattice. -/
theorem bornRecover_univ (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (hpsi : ∑ z, ‖psi z‖ ^ 2 = 1) :
    bornRecover v t psi Finset.univ = 1 := by
  have h := unitary_preserves_normSq (continuityUnitary v t)
    (continuityUnitary_unitary v t) psi
  rw [hpsi] at h
  simpa [bornRecover, evolvedState] using h

/-- The Born weights of the evolved state, as a probability distribution on the
lattice. -/
noncomputable def bornPMF (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (hpsi : ∑ z, ‖psi z‖ ^ 2 = 1) : PMF (ZMod N) :=
  PMF.ofFintype (fun z => ENNReal.ofReal (‖evolvedState v t psi z‖ ^ 2)) (by
    rw [← ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
    rw [show ∑ z, ‖evolvedState v t psi z‖ ^ 2 = bornRecover v t psi Finset.univ from rfl,
      bornRecover_univ v t psi hpsi, ENNReal.ofReal_one])

@[simp] theorem bornPMF_apply (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (hpsi : ∑ z, ‖psi z‖ ^ 2 = 1) (z : ZMod N) :
    bornPMF v t psi hpsi z = ENNReal.ofReal (‖evolvedState v t psi z‖ ^ 2) := rfl

/-! ## The capstone: a conditional probability from the dynamics -/

variable {X : Type*}

/-- **Capstone.**  A family of velocity fields `v x` on the lattice, together
with normalized initial states `psi x`, determines by the dynamics-based unitary
(and *no* basis choice) a genuine conditional probability law
`z ↦ |Ψ_t(x, z)|²` for every input `x`: it is a probability distribution, and
its mass on a set `B` of lattice sites is the Born weight `bornRecover`. -/
theorem condProb_of_continuity (v : X → (ZMod N → ℝ)) (t : ℝ)
    (psi : X → ZMod N → ℂ) (hpsi : ∀ x, ∑ z, ‖psi x z‖ ^ 2 = 1) (x : X) :
    (∑' z, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset (ZMod N),
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by
  refine ⟨(bornPMF (v x) t (psi x) (hpsi x)).tsum_coe, fun B => ?_⟩
  rw [bornRecover, ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
  exact Finset.sum_congr rfl fun z _ => bornPMF_apply _ _ _ _ z

/-! ## The finite tensor–product identification `L²(X) ⊗ L²(Z) ≅ L²(X × Z)` -/

/-- Swapping and currying: `(Z → X → ℂ) ≃ₗ (X × Z → ℂ)`. -/
def swapCurry (X Z : Type*) : (Z → X → ℂ) ≃ₗ[ℂ] (X × Z → ℂ) where
  toFun F := fun p => F p.2 p.1
  invFun G := fun z x => G (x, z)
  map_add' _ _ := rfl
  map_smul' _ _ := rfl
  left_inv _ := rfl
  right_inv _ := rfl

/-- **The tensor–product identification at the finite index level:**
`L²(X) ⊗ L²(Z) ≅ L²(X × Z)`.  This is what lets the dynamics-based generator be
an ordinary Hermitian matrix on the *scalar* space `L²(X × Z)`, with no
Bochner-space machinery. -/
noncomputable def tensorIsom (X Z : Type*) [Fintype Z] [DecidableEq Z] :
    ((X → ℂ) ⊗[ℂ] (Z → ℂ)) ≃ₗ[ℂ] (X × Z → ℂ) :=
  (TensorProduct.piScalarRight ℂ ℂ (X → ℂ) Z).trans (swapCurry X Z)

@[simp] theorem tensorIsom_tmul (X Z : Type*) [Fintype Z] [DecidableEq Z]
    (f : X → ℂ) (g : Z → ℂ) :
    tensorIsom X Z (f ⊗ₜ g) = fun p => f p.1 * g p.2 := by
  funext p
  simp [tensorIsom, swapCurry, mul_comm]

/-- A product initial state `Ψ₀(x, z) = f(x) e₀(z)`, in the `L²(X × Z)` picture. -/
noncomputable def productState (X : Type*) {Z : Type*} [Fintype Z] [DecidableEq Z]
    (f : X → ℂ) (e0 : Z → ℂ) : X × Z → ℂ := tensorIsom X Z (f ⊗ₜ e0)

/-- **Born recovery for a product initial state.**  If `|f x| = 1` and `e₀` is
normalized, the `x`-slice of the product state `Ψ₀ = f ⊗ e₀` is normalized, so
the dynamics-based evolution of that slice gives a probability law on the
lattice: the conditional `P(x, B) = ∑_{z ∈ B} |Ψ_t(x, z)|²` is recovered by the
ordinary Born rule. -/
theorem bornRecover_product_state (f : X → ℂ) (e0 : ZMod N → ℂ)
    (hf : ∀ x, ‖f x‖ = 1) (he0 : ∑ z, ‖e0 z‖ ^ 2 = 1)
    (v : X → (ZMod N → ℝ)) (t : ℝ) (x : X) :
    bornRecover (v x) t (fun z => productState X f e0 (x, z)) Finset.univ = 1 := by
  refine bornRecover_univ _ _ _ ?_
  have hslice : ∀ z, ‖productState X f e0 (x, z)‖ ^ 2 = ‖e0 z‖ ^ 2 := by
    intro z
    simp [productState, hf x]
  simp only [hslice]
  exact he0

end BookProof.ChapterContinuityUnitary
