import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3b
import BookProof.ChapterA3c
import BookProof.ChapterA3d

/-!
# Chapter A, §A.3 — the Lie algebra `𝔰𝔭𝔦𝔫⁺(3,1)` (infinitesimal Note 47 / Lemma 48)

This file continues work-package **N4** of `FORMALIZATION_ROADMAP.md`
(book §A.3, **Note 47 / Lemma 48**, book line 5445).  The book characterizes the
restricted spin group by its Lie algebra,

`Spin⁺(3,1) = { e^{θʲ iγ⁵γ⁰γʲ + bʲ γ⁰γʲ} : θ, b ∈ ℝ³ }`,

whose Lie algebra `𝔰𝔭𝔦𝔫⁺(3,1)` is spanned by the six **spinor Lorentz
generators**

* the three **boosts**    `γ⁰γʲ = -(iγ⁰)(iγʲ)`   (`j = 1,2,3`), and
* the three **rotations**  `iγ⁵γ⁰γʲ = iγ⁵·(γ⁰γʲ)` (`j = 1,2,3`).

We formalize the *infinitesimal* content of Note 47 / Lemma 48 — the differential
`Λ_* : 𝔰𝔭𝔦𝔫⁺(3,1) → 𝔬(1,3)` of the two-to-one covering `Λ : Pin(3,1) → O(1,3)`
of `ChapterA3c.lean`.  Concretely, for a Lie-algebra element `G` the *adjoint*
(commutator) action on the Majorana basis is a real `4×4` matrix `A`:

`HasAdLambda G A  :  ∀ μ, [G, iγ^μ] = G·iγ^μ - iγ^μ·G = Σ_ν A^μ_ν iγ^ν`,

and this `A` lies in the **Lorentz Lie algebra** `𝔬(1,3) = {A | A η + η Aᵀ = 0}`
(the derivative of the defining relation `Λ η Λᵀ = η` of `LorentzO`).  Everything
is over `ℝ` on the concrete `4×4` Majorana model (`mgammaR`), and every
per-generator fact is a decidable integer-matrix computation (`decide`), so the
file is fully self-contained: **no external hypothesis** (no Pauli/Weyl input) is
needed.

Deliverables:
* generators `spinBoost j`, `spinRot j` and their explicit adjoint matrices
  `adBoost j`, `adRot j`;
* `spinGen_traceless` — the six generators are traceless (so their exponentials
  have unit determinant — the group-level `det S = 1` of Lemma 48);
* `spinBoost_hasAdLambda` / `spinRot_hasAdLambda` — `[G, iγ^μ] = Σ A^μ_ν iγ^ν`;
* `adBoost_mem_lorentzLie` / `adRot_mem_lorentzLie` — each adjoint matrix is in
  `𝔬(1,3)`;
* linearity (`hasAdLambda_add`, `hasAdLambda_smul`, `lorentzLie` a subspace) and
  the headline **`spinLie_hasAdLambda_lorentzLie`**: every element of
  `𝔰𝔭𝔦𝔫⁺(3,1)` has an adjoint matrix lying in `𝔬(1,3)` — i.e. the
  infinitesimal Lorentz map `Λ_*` is well-defined and lands in `𝔬(1,3)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).

**Remaining group-level step (recorded open item).**  Exponentiating this to the
group statement `Spin⁺(3,1) ⊆ Pin(3,1)` and `Λ(S) = Υ(Σ⁻¹SΣ)` requires the
matrix-exponential determinant identity `det (exp A) = exp (tr A)` — currently a
listed *TODO* in Mathlib (`Mathlib/Analysis/Normed/Algebra/MatrixExponential.lean`)
— together with the adjoint-exponential identity `exp(-G)·X·exp(G) = exp(-ad_G)(X)`.
Those analytic ingredients are the recorded obstruction; the algebraic/Lie-algebra
core (this file) is complete.
-/

open Matrix

namespace BookProof.ChapterA3

/-! ## The integer generators and adjoint matrices -/

/-- The spatial index `j ↦ j+1 : Fin 4` (so `j = 0,1,2 ↦ 1,2,3`). -/
def spinIdx (j : Fin 3) : Fin 4 := ⟨j.val + 1, by omega⟩

/-- The boost generator `γ⁰γʲ = -(iγ⁰)(iγʲ)` over `ℤ`. -/
def spinBoostZ (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℤ :=
  -(mgammaZ 0 * mgammaZ (spinIdx j))

/-- The rotation generator `iγ⁵γ⁰γʲ = iγ⁵·(γ⁰γʲ)` over `ℤ`. -/
def spinRotZ (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℤ :=
  mgamma5Z * spinBoostZ j

/-- The adjoint (commutator) matrix of the boost `γ⁰γʲ` on the Majorana basis. -/
def adBoostZ : Fin 3 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => !![0,-2,0,0; -2,0,0,0; 0,0,0,0; 0,0,0,0]
  | 1 => !![0,0,-2,0; 0,0,0,0; -2,0,0,0; 0,0,0,0]
  | 2 => !![0,0,0,-2; 0,0,0,0; 0,0,0,0; -2,0,0,0]

/-- The adjoint (commutator) matrix of the rotation `iγ⁵γ⁰γʲ` on the Majorana
basis. -/
def adRotZ : Fin 3 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => !![0,0,0,0; 0,0,0,0; 0,0,0,2; 0,0,-2,0]
  | 1 => !![0,0,0,0; 0,0,0,-2; 0,0,0,0; 0,2,0,0]
  | 2 => !![0,0,0,0; 0,0,2,0; 0,-2,0,0; 0,0,0,0]

/-! ## The real generators and adjoint matrices -/

/-- The boost generator `γ⁰γʲ` as a real matrix. -/
noncomputable def spinBoost (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℝ :=
  (Int.castRingHom ℝ).mapMatrix (spinBoostZ j)

/-- The rotation generator `iγ⁵γ⁰γʲ` as a real matrix. -/
noncomputable def spinRot (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℝ :=
  (Int.castRingHom ℝ).mapMatrix (spinRotZ j)

/-- The adjoint matrix of the boost `γ⁰γʲ` as a real matrix. -/
noncomputable def adBoost (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℝ :=
  (Int.castRingHom ℝ).mapMatrix (adBoostZ j)

/-- The adjoint matrix of the rotation `iγ⁵γ⁰γʲ` as a real matrix. -/
noncomputable def adRot (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℝ :=
  (Int.castRingHom ℝ).mapMatrix (adRotZ j)

/-! ## The infinitesimal predicates -/

/-- `HasAdLambda G A`: the real matrix `A` describes the *adjoint* (commutator)
action of `G` on the Majorana basis, `[G, iγ^μ] = Σ_ν A^μ_ν (iγ^ν)`.  This is the
infinitesimal analogue of `HasLambda` (`ChapterA3c.lean`). -/
def HasAdLambda (G A : Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  ∀ μ, G * mgammaR μ - mgammaR μ * G = ∑ ν, A μ ν • mgammaR ν

/-- The **Lorentz Lie algebra** `𝔬(1,3) = {A | A η + η Aᵀ = 0}`, the derivative of
the defining relation `Λ η Λᵀ = η` of `LorentzO`. -/
def LorentzLie : Set (Matrix (Fin 4) (Fin 4) ℝ) :=
  {A | A * minkowskiMat + minkowskiMat * Aᵀ = 0}

/-! ## Casting helpers -/

/-- The integer Minkowski matrix casts to the real one. -/
theorem castMat_minkowskiMatZ :
    (Int.castRingHom ℝ).mapMatrix minkowskiMatZ = minkowskiMat := by
  ext i j
  simp [RingHom.mapMatrix_apply, Matrix.map_apply, minkowskiMatZ, minkowskiMat,
    minkowskiR]

/-- **Reduction to the integer model** for the adjoint action.  If the integer
commutator identity `Gz·iγ^μ - iγ^μ·Gz = Σ_ν Az^μ_ν iγ^ν` holds, then the real
casts satisfy `HasAdLambda`. -/
theorem hasAdLambda_of_intModel (Gz Az : Matrix (Fin 4) (Fin 4) ℤ)
    (hconj : ∀ μ, Gz * mgammaZ μ - mgammaZ μ * Gz = ∑ ν, Az μ ν • mgammaZ ν) :
    HasAdLambda ((Int.castRingHom ℝ).mapMatrix Gz)
      ((Int.castRingHom ℝ).mapMatrix Az) := by
  intro μ
  have hmg : mgammaR μ = (Int.castRingHom ℝ).mapMatrix (mgammaZ μ) := rfl
  have hL : (Int.castRingHom ℝ).mapMatrix Gz * mgammaR μ
      - mgammaR μ * (Int.castRingHom ℝ).mapMatrix Gz
      = (Int.castRingHom ℝ).mapMatrix (Gz * mgammaZ μ - mgammaZ μ * Gz) := by
    rw [hmg]; simp only [map_sub, map_mul]
  rw [hL, hconj μ, map_sum]
  apply Finset.sum_congr rfl
  intro ν _
  have hcast : ((Int.castRingHom ℝ).mapMatrix Az) μ ν = ((Az μ ν : ℤ) : ℝ) := by
    simp [RingHom.mapMatrix_apply, Matrix.map_apply]
  rw [hcast, map_zsmul, Int.cast_smul_eq_zsmul]
  rfl

/-- **Reduction to the integer model** for the `𝔬(1,3)` membership.  If the
integer identity `Az η + η Azᵀ = 0` holds, then the real cast lies in
`LorentzLie`. -/
theorem lorentzLie_of_intModel (Az : Matrix (Fin 4) (Fin 4) ℤ)
    (h : Az * minkowskiMatZ + minkowskiMatZ * Azᵀ = 0) :
    (Int.castRingHom ℝ).mapMatrix Az ∈ LorentzLie := by
  have hc := congrArg (Int.castRingHom ℝ).mapMatrix h
  rw [map_add, map_mul, map_mul, map_zero] at hc
  have ht : (Int.castRingHom ℝ).mapMatrix (Azᵀ)
      = ((Int.castRingHom ℝ).mapMatrix Az)ᵀ := by
    rw [RingHom.mapMatrix_apply, RingHom.mapMatrix_apply, Matrix.transpose_map]
  rw [ht, castMat_minkowskiMatZ] at hc
  exact hc

/-! ## The generators are traceless -/

theorem spinBoost_traceless (j : Fin 3) : (spinBoost j).trace = 0 := by
  have h : (spinBoostZ j).trace = 0 := by fin_cases j <;> decide
  have he : (spinBoost j).trace = (Int.castRingHom ℝ) ((spinBoostZ j).trace) := by
    simp [spinBoost, Matrix.trace, Matrix.diag, RingHom.mapMatrix_apply,
      Matrix.map_apply, map_sum]
  rw [he, h, map_zero]

theorem spinRot_traceless (j : Fin 3) : (spinRot j).trace = 0 := by
  have h : (spinRotZ j).trace = 0 := by fin_cases j <;> decide
  have he : (spinRot j).trace = (Int.castRingHom ℝ) ((spinRotZ j).trace) := by
    simp [spinRot, Matrix.trace, Matrix.diag, RingHom.mapMatrix_apply,
      Matrix.map_apply, map_sum]
  rw [he, h, map_zero]

/-! ## The adjoint identities and `𝔬(1,3)` membership -/

theorem spinBoost_hasAdLambda (j : Fin 3) : HasAdLambda (spinBoost j) (adBoost j) := by
  have hconj : ∀ μ, spinBoostZ j * mgammaZ μ - mgammaZ μ * spinBoostZ j
      = ∑ ν, (adBoostZ j) μ ν • mgammaZ ν := by
    fin_cases j <;> decide
  exact hasAdLambda_of_intModel (spinBoostZ j) (adBoostZ j) hconj

theorem spinRot_hasAdLambda (j : Fin 3) : HasAdLambda (spinRot j) (adRot j) := by
  have hconj : ∀ μ, spinRotZ j * mgammaZ μ - mgammaZ μ * spinRotZ j
      = ∑ ν, (adRotZ j) μ ν • mgammaZ ν := by
    fin_cases j <;> decide
  exact hasAdLambda_of_intModel (spinRotZ j) (adRotZ j) hconj

theorem adBoost_mem_lorentzLie (j : Fin 3) : adBoost j ∈ LorentzLie := by
  have h : adBoostZ j * minkowskiMatZ + minkowskiMatZ * (adBoostZ j)ᵀ = 0 := by
    fin_cases j <;> decide
  exact lorentzLie_of_intModel (adBoostZ j) h

theorem adRot_mem_lorentzLie (j : Fin 3) : adRot j ∈ LorentzLie := by
  have h : adRotZ j * minkowskiMatZ + minkowskiMatZ * (adRotZ j)ᵀ = 0 := by
    fin_cases j <;> decide
  exact lorentzLie_of_intModel (adRotZ j) h

/-! ## Linearity -/

theorem hasAdLambda_add {G₁ G₂ A₁ A₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (h1 : HasAdLambda G₁ A₁) (h2 : HasAdLambda G₂ A₂) :
    HasAdLambda (G₁ + G₂) (A₁ + A₂) := by
  intro μ
  have := h1 μ
  have := h2 μ
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.add_apply]
  rw [show ∑ ν, (A₁ μ ν + A₂ μ ν) • mgammaR ν
        = (∑ ν, A₁ μ ν • mgammaR ν) + ∑ ν, A₂ μ ν • mgammaR ν from ?_]
  · rw [← h1 μ, ← h2 μ]; abel
  · rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun ν _ => by rw [add_smul]

theorem hasAdLambda_smul {G A : Matrix (Fin 4) (Fin 4) ℝ} (c : ℝ)
    (h : HasAdLambda G A) : HasAdLambda (c • G) (c • A) := by
  intro μ
  have := h μ
  simp only [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_apply, smul_eq_mul]
  rw [show ∑ ν, (c * A μ ν) • mgammaR ν = c • ∑ ν, A μ ν • mgammaR ν from ?_]
  · rw [← h μ, smul_sub]
  · rw [Finset.smul_sum]
    exact Finset.sum_congr rfl fun ν _ => by rw [smul_smul]

theorem hasAdLambda_zero : HasAdLambda (0 : Matrix (Fin 4) (Fin 4) ℝ) 0 := by
  intro μ; simp

theorem hasAdLambda_sum {ι : Type*} (s : Finset ι)
    (G A : ι → Matrix (Fin 4) (Fin 4) ℝ) (h : ∀ i ∈ s, HasAdLambda (G i) (A i)) :
    HasAdLambda (∑ i ∈ s, G i) (∑ i ∈ s, A i) := by
  classical
  induction s using Finset.induction with
  | empty => simpa using hasAdLambda_zero
  | insert i s hi ih =>
      rw [Finset.sum_insert hi, Finset.sum_insert hi]
      exact hasAdLambda_add (h i (Finset.mem_insert_self i s))
        (ih fun k hk => h k (Finset.mem_insert_of_mem hk))

theorem lorentzLie_add {A₁ A₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (h1 : A₁ ∈ LorentzLie) (h2 : A₂ ∈ LorentzLie) : A₁ + A₂ ∈ LorentzLie := by
  simp only [LorentzLie, Set.mem_setOf_eq] at *
  have hd : (A₁ + A₂) * minkowskiMat + minkowskiMat * (A₁ + A₂)ᵀ
      = (A₁ * minkowskiMat + minkowskiMat * A₁ᵀ)
        + (A₂ * minkowskiMat + minkowskiMat * A₂ᵀ) := by
    simp only [Matrix.add_mul, Matrix.mul_add, Matrix.transpose_add]; abel
  rw [hd, h1, h2, add_zero]

theorem lorentzLie_smul {A : Matrix (Fin 4) (Fin 4) ℝ} (c : ℝ)
    (h : A ∈ LorentzLie) : c • A ∈ LorentzLie := by
  simp only [LorentzLie, Set.mem_setOf_eq] at *
  rw [Matrix.smul_mul, Matrix.transpose_smul, Matrix.mul_smul, ← smul_add, h,
    smul_zero]

theorem lorentzLie_zero : (0 : Matrix (Fin 4) (Fin 4) ℝ) ∈ LorentzLie := by
  simp [LorentzLie]

theorem lorentzLie_sum {ι : Type*} (s : Finset ι) (A : ι → Matrix (Fin 4) (Fin 4) ℝ)
    (h : ∀ i ∈ s, A i ∈ LorentzLie) : (∑ i ∈ s, A i) ∈ LorentzLie := by
  classical
  induction s using Finset.induction with
  | empty => simpa using lorentzLie_zero
  | insert i s hi ih =>
      rw [Finset.sum_insert hi]
      exact lorentzLie_add (h i (Finset.mem_insert_self i s))
        (ih fun k hk => h k (Finset.mem_insert_of_mem hk))

/-! ## The Lie algebra `𝔰𝔭𝔦𝔫⁺(3,1)` and the infinitesimal Lorentz map -/

/-- Membership in the Lie algebra `𝔰𝔭𝔦𝔫⁺(3,1)`: a real combination of the six
spinor Lorentz generators (three boosts `γ⁰γʲ`, three rotations `iγ⁵γ⁰γʲ`). -/
def IsSpinLie (G : Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  ∃ b r : Fin 3 → ℝ,
    G = (∑ j, b j • spinBoost j) + ∑ j, r j • spinRot j

/-- **Infinitesimal Note 47 / Lemma 48 (headline).**  Every element `G` of the
Lie algebra `𝔰𝔭𝔦𝔫⁺(3,1)` has a well-defined adjoint matrix `A` — the value of
the differential Lorentz map `Λ_*(G)` — and this `A` lies in the Lorentz Lie
algebra `𝔬(1,3)`.  Thus `Λ_* : 𝔰𝔭𝔦𝔫⁺(3,1) → 𝔬(1,3)` is well-defined. -/
theorem spinLie_hasAdLambda_lorentzLie {G : Matrix (Fin 4) (Fin 4) ℝ}
    (hG : IsSpinLie G) : ∃ A, HasAdLambda G A ∧ A ∈ LorentzLie := by
  obtain ⟨b, r, rfl⟩ := hG
  refine ⟨(∑ j, b j • adBoost j) + ∑ j, r j • adRot j, ?_, ?_⟩
  · exact hasAdLambda_add
      (hasAdLambda_sum _ _ _ fun j _ =>
        hasAdLambda_smul (b j) (spinBoost_hasAdLambda j))
      (hasAdLambda_sum _ _ _ fun j _ =>
        hasAdLambda_smul (r j) (spinRot_hasAdLambda j))
  · exact lorentzLie_add
      (lorentzLie_sum _ _ fun j _ => lorentzLie_smul (b j) (adBoost_mem_lorentzLie j))
      (lorentzLie_sum _ _ fun j _ => lorentzLie_smul (r j) (adRot_mem_lorentzLie j))

/-- **Infinitesimal `det = 1` of Lemma 48.**  Every element of `𝔰𝔭𝔦𝔫⁺(3,1)` is
traceless (so its exponential has unit determinant). -/
theorem spinLie_traceless {G : Matrix (Fin 4) (Fin 4) ℝ} (hG : IsSpinLie G) :
    G.trace = 0 := by
  obtain ⟨b, r, rfl⟩ := hG
  rw [Matrix.trace_add, Matrix.trace_sum, Matrix.trace_sum]
  simp only [Matrix.trace_smul, spinBoost_traceless, spinRot_traceless, smul_zero,
    Finset.sum_const_zero, add_zero]

end BookProof.ChapterA3
