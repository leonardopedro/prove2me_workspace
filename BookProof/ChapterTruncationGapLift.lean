import Mathlib
import BookProof.ChapterYangMillsFockGapChain

/-!
# Chapter TruncationGapLift — from a certified *truncated* gap to the *infinite* operator

`CONSOLIDATED_PLAN.md`, QYM-1 **task 2**: "Prove the finite/truncated one-particle gap
certified by the bands lifts to the infinite one-particle operator and then (via `dGamma`)
to the outer-enclosed final Hamiltonian — the current certificate proves only the truncated
gap; the bridge is the specialist's analytic input."

This chapter supplies exactly that bridge, and is careful about what it costs.

## The two halves of the lift

Write `Vₘ = galerkinSpan b m` for the order-`m` truncation and
`Wₘ = tailSpan b m = span {b i | m ≤ i}` for its tail inside the finite-mode core
`D = finiteModeDomain b`.  The two are orthogonal and together span `D`
(`galerkinSpan_sup_tailSpan`, `inner_eq_zero_of_mem_galerkin_tail`), so every core vector
splits as `v = x + w` with `x ∈ Vₘ`, `w ∈ Wₘ` and `‖v‖² = ‖x‖² + ‖w‖²`.

* **The cheap half.**  If the truncated gap holds *uniformly in `m`* — the same `μ` at
  every order — then the core form gap follows with no analytic input at all, because every
  core vector already lies in some `Vₘ` (`gap_of_uniform_truncated_gap`).  This is the
  honest statement of what "the Ritz values are all above `μ`" gives you.

* **The real half.**  A certificate proves the truncated gap at *finitely many* orders — in
  practice at a single order `m`.  Lifting that to the core needs two further inputs, and
  they are the analytic content:
  1. **tail coercivity** `⟪w, H w⟫ ≥ μ‖w‖²` for `w ∈ Wₘ`, and
  2. a **coupling bound** `|Re ⟪x, H w⟫| ≤ ε‖x‖‖w‖` across the split.

  Then `⟪v, H v⟫ ≥ (μ − ε)‖v‖²` on the whole core (`gap_of_level_gap_and_tail`), by the
  block estimate `2‖x‖‖w‖ ≤ ‖x‖² + ‖w‖²`.  The decoupled case `ε = 0` is
  `gap_of_level_gap_and_tail_decoupled`.

Both inputs are genuinely needed: `quadForm_add_of_symmetricOn` is an *identity*, so a
coupling of size `ε > μ` cancels the whole gap, and without the tail bound the certificate
says nothing about the modes it never saw.  Nothing here manufactures either input.

## Deliverables

* `tailSpan` and its structure lemmas: `tailSpan_le_finiteModeDomain`,
  `galerkinSpan_sup_tailSpan`, `inner_eq_zero_of_mem_galerkin_tail`,
  `norm_add_sq_of_galerkin_tail`, `exists_galerkin_tail_decomp`;
* `quadForm_add_of_symmetricOn` — the exact two-block expansion of the energy form;
* **`gap_of_uniform_truncated_gap`** — uniform truncated gap ⇒ core form gap;
* **`gap_of_level_gap_and_tail`** — one certified level + tail coercivity + coupling bound
  ⇒ core form gap `μ − ε`;
* `quadForm_ge_of_le_ritzInf_on` and `gap_of_le_ritzInf_and_tail` — the same with the
  truncated input in Ritz-value form, as a certificate delivers it;
* **`ym_fock_gap_of_truncated_gap_and_tail`** and
  **`ym_fock_mass_gap_of_truncated_gap_and_tail`** — the composition with the Yang–Mills
  `dΓ` chain: the certified order-`m` gap of the gauge-fixed one-particle Hamiltonian,
  together with the two analytic inputs, gives the nested-Fock conclusion for the final
  Hamiltonian `dΓ(H₁)`;
* `ym_fock_gap_of_band_and_tail` — the same starting from a certified band whose lower end
  is at least `μ`, so no displayed Ritz value is ever read as a lower bound.

## Honest boundary

The tail coercivity and the coupling bound are **hypotheses**, not conclusions: they are the
named analytic input QYM-1 task 3 refers to, and they are not proved for the gauge-fixed
Yang–Mills one-particle operator here.  What is proved is that the certificate's truncated
gap plus those two inputs is *sufficient*, with the explicit constant `μ − ε`, and that no
step of the chain reads a numerical Ritz value as a lower bound.  No mass gap of the
physical Yang–Mills Hamiltonian is claimed.

Everything in this module is `sorry`-free and `axiom`-free.
-/

noncomputable section

namespace BookProof.TruncationGapLift

open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.BandEnclosure
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-! ## 1. The tail of a truncation -/

/-- **The tail subspace** of the order-`m` truncation: the span of the basis vectors the
order-`m` Galerkin space does *not* see.  A finite certificate says nothing about it. -/
def tailSpan (b : HilbertBasis ℕ ℂ F) (m : ℕ) : Submodule ℂ F :=
  Submodule.span ℂ (b '' {i | m ≤ i})

theorem basis_mem_tailSpan (b : HilbertBasis ℕ ℂ F) {i m : ℕ} (him : m ≤ i) :
    b i ∈ tailSpan b m :=
  Submodule.subset_span ⟨i, him, rfl⟩

theorem tailSpan_le_finiteModeDomain (b : HilbertBasis ℕ ℂ F) (m : ℕ) :
    tailSpan b m ≤ finiteModeDomain b :=
  Submodule.span_mono (by rintro x ⟨i, _, rfl⟩; exact ⟨i, rfl⟩)

/-- **The truncation and its tail exhaust the core.** -/
theorem galerkinSpan_sup_tailSpan (b : HilbertBasis ℕ ℂ F) (m : ℕ) :
    galerkinSpan b m ⊔ tailSpan b m = finiteModeDomain b := by
  have hset : ({i | i < m} ∪ {i | m ≤ i} : Set ℕ) = Set.univ := by
    ext i
    simp only [Set.mem_union, Set.mem_setOf_eq, Set.mem_univ, iff_true]
    omega
  rw [galerkinSpan, tailSpan, ← Submodule.span_union, ← Set.image_union, hset,
    Set.image_univ, finiteModeDomain]

/-- **The truncation and its tail are orthogonal.** -/
theorem inner_eq_zero_of_mem_galerkin_tail (b : HilbertBasis ℕ ℂ F) {m : ℕ}
    {x w : F} (hx : x ∈ galerkinSpan b m) (hw : w ∈ tailSpan b m) :
    (inner ℂ x w : ℂ) = 0 := by
  have hgen : ∀ j : ℕ, m ≤ j → ∀ y ∈ galerkinSpan b m, (inner ℂ y (b j) : ℂ) = 0 := by
    intro j hj y hy
    induction hy using Submodule.span_induction with
    | mem z hz =>
        obtain ⟨i, hi, rfl⟩ := hz
        simp only [Set.mem_setOf_eq] at hi
        exact b.orthonormal.2 (by omega)
    | zero => simp
    | add u v _ _ hu hv => rw [inner_add_left, hu, hv, add_zero]
    | smul c u _ hu => rw [inner_smul_left, hu, mul_zero]
  induction hw using Submodule.span_induction with
  | mem z hz =>
      obtain ⟨j, hj, rfl⟩ := hz
      exact hgen j hj x hx
  | zero => simp
  | add u v _ _ hu hv => rw [inner_add_right, hu, hv, add_zero]
  | smul c u _ hu => rw [inner_smul_right, hu, mul_zero]

/-- Pythagoras across the split. -/
theorem norm_add_sq_of_galerkin_tail (b : HilbertBasis ℕ ℂ F) {m : ℕ}
    {x w : F} (hx : x ∈ galerkinSpan b m) (hw : w ∈ tailSpan b m) :
    ‖x + w‖ ^ 2 = ‖x‖ ^ 2 + ‖w‖ ^ 2 := by
  have h := norm_add_sq_eq_norm_sq_add_norm_sq_of_inner_eq_zero x w
    (inner_eq_zero_of_mem_galerkin_tail b hx hw)
  simpa [pow_two] using h

/-- **The two-block decomposition of a core vector.** -/
theorem exists_galerkin_tail_decomp (b : HilbertBasis ℕ ℂ F) (m : ℕ)
    {v : F} (hv : v ∈ finiteModeDomain b) :
    ∃ x ∈ galerkinSpan b m, ∃ w ∈ tailSpan b m, v = x + w := by
  rw [← galerkinSpan_sup_tailSpan b m, Submodule.mem_sup] at hv
  obtain ⟨x, hx, w, hw, hxw⟩ := hv
  exact ⟨x, hx, w, hw, hxw.symm⟩

/-! ## 2. The block expansion of the energy form -/

variable {D : Submodule ℂ F}

/-- **The exact two-block expansion.**  For a symmetric operator the energy of a sum is the
sum of the block energies plus twice the real part of the coupling.  This is an identity:
the coupling term is not an error one can drop. -/
theorem quadForm_add_of_symmetricOn (H : D →ₗ[ℂ] F) (hsym : SymmetricOn D H) (x w : D) :
    quadForm H (x + w) = quadForm H x + quadForm H w
      + 2 * (inner ℂ (x : F) (H w) : ℂ).re := by
  have hcross : (inner ℂ (w : F) (H x) : ℂ).re = (inner ℂ (x : F) (H w) : ℂ).re := by
    have h1 : (inner ℂ (H x) (w : F) : ℂ) = inner ℂ (x : F) (H w) := hsym x w
    have h2 : (inner ℂ (w : F) (H x) : ℂ) = starRingEnd ℂ (inner ℂ (H x) (w : F) : ℂ) :=
      (inner_conj_symm (𝕜 := ℂ) (w : F) (H x)).symm
    rw [h2, h1, Complex.conj_re]
  simp only [quadForm, Submodule.coe_add, map_add, inner_add_left, inner_add_right,
    Complex.add_re]
  rw [hcross]
  ring

/-! ## 3. The lift -/

/-- **The cheap half of the lift.**  If the truncated gap holds with the *same* `μ` at every
order, the core form gap follows immediately: every core vector already lives in some
Galerkin subspace, so no limiting process and no analytic input is needed. -/
theorem gap_of_uniform_truncated_gap (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) {mu : ℝ}
    (htrunc : ∀ m : ℕ, ∀ x : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x)
    (v : finiteModeDomain b) : mu * ‖(v : F)‖ ^ 2 ≤ quadForm H v := by
  obtain ⟨m, hm⟩ := exists_mem_galerkinSpan b v.2
  exact htrunc m v hm

/-- **The real half of the lift.**  A gap certified at the *single* order `m`, together with
tail coercivity at the same level and a coupling bound `ε ≥ 0` across the split, gives the
form gap `μ − ε` on the whole finite-mode core — the infinite one-particle operator. -/
theorem gap_of_level_gap_and_tail (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H) {m : ℕ} {mu eps : ℝ}
    (heps : 0 ≤ eps)
    (htrunc : ∀ x : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x)
    (htail : ∀ w : finiteModeDomain b, (w : F) ∈ tailSpan b m →
      mu * ‖(w : F)‖ ^ 2 ≤ quadForm H w)
    (hcoup : ∀ x w : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      (w : F) ∈ tailSpan b m →
      |(inner ℂ (x : F) (H w) : ℂ).re| ≤ eps * ‖(x : F)‖ * ‖(w : F)‖)
    (v : finiteModeDomain b) : (mu - eps) * ‖(v : F)‖ ^ 2 ≤ quadForm H v := by
  obtain ⟨x, hx, w, hw, hxw⟩ := exists_galerkin_tail_decomp b m v.2
  let X : finiteModeDomain b := ⟨x, galerkinSpan_le_finiteModeDomain b m hx⟩
  let W : finiteModeDomain b := ⟨w, tailSpan_le_finiteModeDomain b m hw⟩
  have hXc : (X : F) = x := rfl
  have hWc : (W : F) = w := rfl
  have hv : v = X + W := Subtype.ext (by simpa [hXc, hWc] using hxw)
  have hqv : quadForm H v
      = quadForm H X + quadForm H W + 2 * (inner ℂ (X : F) (H W) : ℂ).re := by
    rw [hv]; exact quadForm_add_of_symmetricOn H hsym X W
  have hnorm : ‖(v : F)‖ ^ 2 = ‖x‖ ^ 2 + ‖w‖ ^ 2 := by
    rw [hxw]; exact norm_add_sq_of_galerkin_tail b hx hw
  have h1 : mu * ‖x‖ ^ 2 ≤ quadForm H X := htrunc X hx
  have h2 : mu * ‖w‖ ^ 2 ≤ quadForm H W := htail W hw
  have h3 : |(inner ℂ (X : F) (H W) : ℂ).re| ≤ eps * ‖x‖ * ‖w‖ := hcoup X W hx hw
  have hcross : -(eps * ‖x‖ * ‖w‖) ≤ (inner ℂ (X : F) (H W) : ℂ).re := (abs_le.mp h3).1
  have hsq : 0 ≤ eps * (‖x‖ - ‖w‖) ^ 2 := mul_nonneg heps (sq_nonneg _)
  rw [hqv, hnorm]
  nlinarith [hsq, hcross, h1, h2]

/-- The decoupled case: if the truncation is exactly block-diagonal for `H`, the certified
level gap and the tail gap combine with no loss. -/
theorem gap_of_level_gap_and_tail_decoupled (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H) {m : ℕ} {mu : ℝ}
    (htrunc : ∀ x : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x)
    (htail : ∀ w : finiteModeDomain b, (w : F) ∈ tailSpan b m →
      mu * ‖(w : F)‖ ^ 2 ≤ quadForm H w)
    (hdec : ∀ x w : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      (w : F) ∈ tailSpan b m → (inner ℂ (x : F) (H w) : ℂ).re = 0)
    (v : finiteModeDomain b) : mu * ‖(v : F)‖ ^ 2 ≤ quadForm H v := by
  have h := gap_of_level_gap_and_tail (eps := 0) b H hsym le_rfl htrunc htail
    (by intro x w hx hw; simp [hdec x w hx hw]) v
  simpa using h

/-! ## 4. The truncated input in Ritz form

A certificate delivers a *Ritz* bound at level `m`, not a form bound.  These two lemmas
convert. -/

/-- **A Ritz bound on a subspace is a form bound on that subspace.**  This is
`BandEnclosure.quadForm_ge_of_le_ritzInf` with the domain `D` replaced by an arbitrary
truncation subspace `V`. -/
theorem quadForm_ge_of_le_ritzInf_on (H : D →ₗ[ℂ] F)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) {V : Submodule ℂ F} {mu : ℝ}
    (hmu : mu ≤ ritzInf H V) (x : D) (hx : (x : F) ∈ V) :
    mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x := by
  rcases eq_or_ne ((x : F)) 0 with hx0 | hxne
  · have : x = 0 := Subtype.ext hx0
    simp [this, quadForm]
  · have hnpos : 0 < ‖(x : F)‖ := norm_pos_iff.mpr hxne
    set c : ℝ := ‖(x : F)‖⁻¹ with hc
    have hunit : ‖(((c : ℂ) • x : D) : F)‖ = 1 := by
      rw [Submodule.coe_smul, norm_smul]
      simp [hc, hnpos.ne']
    have hmemV : (((c : ℂ) • x : D) : F) ∈ V := by
      rw [Submodule.coe_smul]; exact V.smul_mem _ hx
    have hmem : quadForm H ((c : ℂ) • x) ∈ ritzSet H V :=
      ⟨(c : ℂ) • x, hmemV, hunit, rfl⟩
    have hle : ritzInf H V ≤ quadForm H ((c : ℂ) • x) :=
      csInf_le (ritzSet_bddBelow H hpos V) hmem
    rw [quadForm_real_smul] at hle
    have hsq : c ^ 2 * ‖(x : F)‖ ^ 2 = 1 := by
      rw [hc, inv_pow, inv_mul_cancel₀ (pow_ne_zero 2 hnpos.ne')]
    have h2 := mul_le_mul_of_nonneg_right (hmu.trans hle) (sq_nonneg ‖(x : F)‖)
    have h3 : c ^ 2 * quadForm H x * ‖(x : F)‖ ^ 2
        = (c ^ 2 * ‖(x : F)‖ ^ 2) * quadForm H x := by ring
    rw [h3, hsq, one_mul] at h2
    exact h2

/-- **The certificate route.**  The order-`m` Ritz value is at least `μ` (this is what a
certified band with lower end `μ` asserts), the tail is coercive at the same level, and the
coupling across the split is at most `ε`.  Then the *infinite* one-particle operator has the
form gap `μ − ε` on its whole core. -/
theorem gap_of_le_ritzInf_and_tail (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x) {m : ℕ} {mu eps : ℝ}
    (heps : 0 ≤ eps) (hritz : mu ≤ ritzInf H (galerkinSpan b m))
    (htail : ∀ w : finiteModeDomain b, (w : F) ∈ tailSpan b m →
      mu * ‖(w : F)‖ ^ 2 ≤ quadForm H w)
    (hcoup : ∀ x w : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      (w : F) ∈ tailSpan b m →
      |(inner ℂ (x : F) (H w) : ℂ).re| ≤ eps * ‖(x : F)‖ * ‖(w : F)‖)
    (v : finiteModeDomain b) : (mu - eps) * ‖(v : F)‖ ^ 2 ≤ quadForm H v :=
  gap_of_level_gap_and_tail b H hsym heps
    (fun x hx => quadForm_ge_of_le_ritzInf_on H hpos hritz x hx) htail hcoup v

/-! ## 5. The Yang–Mills instantiation: truncated gap ⇒ final Hamiltonian -/

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

/-- **QYM-1 task 2, for the concrete gauge-fixed one-particle Hamiltonian.**  The gap
certified at the single truncation order `m`, plus tail coercivity and a coupling bound `ε`
at that order, lift to a form gap `μ − ε` of the *infinite* one-particle operator on the
Gauss–polynomial core, and hence — through the `dΓ` chain — to the outer-enclosed final
Hamiltonian: `dΓ(H₁)` annihilates the outer vacuum and has energy at least
`(μ − ε)‖u‖²` on every vacuum-orthogonal finite-particle state. -/
theorem ym_fock_gap_of_truncated_gap_and_tail {m : ℕ} {mu eps : ℝ}
    (heps : 0 ≤ eps) (hmueps : 0 ≤ mu - eps)
    (htrunc : ∀ x : finiteModeDomain (coreBasis e), (x : L2d 99) ∈ galerkinSpan (coreBasis e) m →
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (htail : ∀ w : finiteModeDomain (coreBasis e), (w : L2d 99) ∈ tailSpan (coreBasis e) m →
      mu * ‖(w : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) w)
    (hcoup : ∀ x w : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) m → (w : L2d 99) ∈ tailSpan (coreBasis e) m →
      |(inner ℂ (x : L2d 99) (ymHamiltonian (coreRepBasis e) fabc w) : ℂ).re|
        ≤ eps * ‖(x : L2d 99)‖ * ‖(w : L2d 99)‖) :
    dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (mu - eps) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re :=
  ym_fock_gap_of_one_particle_form_gap e fabc hmueps
    (gap_of_level_gap_and_tail (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc)
      (ymHamiltonian_symmetricOn (coreRepBasis e) fabc) heps htrunc htail hcoup)

/-- **The conditional Yang–Mills nested-Fock mass gap from a certified truncated gap.**
Same hypotheses as `ym_fock_gap_of_truncated_gap_and_tail`, with the strict inequality
`ε < μ`: the final Hamiltonian then has a positive self-adjoint (Friedrichs) extension, the
outer vacuum has energy exactly `0`, and every nonzero vacuum-orthogonal finite-particle
state has strictly positive energy. -/
theorem ym_fock_mass_gap_of_truncated_gap_and_tail {m : ℕ} {mu eps : ℝ}
    (heps : 0 ≤ eps) (hmueps : eps < mu)
    (htrunc : ∀ x : finiteModeDomain (coreBasis e), (x : L2d 99) ∈ galerkinSpan (coreBasis e) m →
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (htail : ∀ w : finiteModeDomain (coreBasis e), (w : L2d 99) ∈ tailSpan (coreBasis e) m →
      mu * ‖(w : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) w)
    (hcoup : ∀ x w : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) m → (w : L2d 99) ∈ tailSpan (coreBasis e) m →
      |(inner ℂ (x : L2d 99) (ymHamiltonian (coreRepBasis e) fabc w) : ℂ).re|
        ≤ eps * ‖(x : L2d 99)‖ * ‖(w : L2d 99)‖) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) A) ∧
      dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re :=
  ym_fock_mass_gap_of_one_particle_form_gap e fabc (by linarith)
    (gap_of_level_gap_and_tail (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc)
      (ymHamiltonian_symmetricOn (coreRepBasis e) fabc) heps htrunc htail hcoup)

/-- **From a certified band, not from a displayed number.**  If the order-`m` Ritz value of
the concrete gauge-fixed one-particle Hamiltonian lies in a certified band whose lower end
is at least `μ`, and the tail and coupling inputs hold at that order, then the final
Hamiltonian `dΓ(H₁)` has the nested-Fock gap `μ − ε`.  The Ritz value itself is never read
as a lower bound: it is only ever used through the band it is certified to lie in. -/
theorem ym_fock_gap_of_band_and_tail {m : ℕ} {mu eps lo hi : ℝ}
    (heps : 0 ≤ eps) (hmueps : 0 ≤ mu - eps)
    (hband : ritzInf (ymHamiltonian (coreRepBasis e) fabc) (galerkinSpan (coreBasis e) m)
      ∈ Set.Icc lo hi)
    (hlo : mu ≤ lo)
    (htail : ∀ w : finiteModeDomain (coreBasis e), (w : L2d 99) ∈ tailSpan (coreBasis e) m →
      mu * ‖(w : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) w)
    (hcoup : ∀ x w : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) m → (w : L2d 99) ∈ tailSpan (coreBasis e) m →
      |(inner ℂ (x : L2d 99) (ymHamiltonian (coreRepBasis e) fabc w) : ℂ).re|
        ≤ eps * ‖(x : L2d 99)‖ * ‖(w : L2d 99)‖) :
    dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (mu - eps) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by
  have hritz : mu ≤ ritzInf (ymHamiltonian (coreRepBasis e) fabc)
      (galerkinSpan (coreBasis e) m) := hlo.trans hband.1
  exact ym_fock_gap_of_truncated_gap_and_tail e fabc heps hmueps
    (fun x hx => quadForm_ge_of_le_ritzInf_on (ymHamiltonian (coreRepBasis e) fabc)
      (ymHamiltonian_quadForm_nonneg (coreRepBasis e) fabc) hritz x hx)
    htail hcoup

/-! ## 6. Axiom audit -/

section Audit

#print axioms galerkinSpan_sup_tailSpan
#print axioms inner_eq_zero_of_mem_galerkin_tail
#print axioms exists_galerkin_tail_decomp
#print axioms quadForm_add_of_symmetricOn
#print axioms gap_of_uniform_truncated_gap
#print axioms gap_of_level_gap_and_tail
#print axioms gap_of_level_gap_and_tail_decoupled
#print axioms quadForm_ge_of_le_ritzInf_on
#print axioms gap_of_le_ritzInf_and_tail
#print axioms ym_fock_gap_of_truncated_gap_and_tail
#print axioms ym_fock_mass_gap_of_truncated_gap_and_tail
#print axioms ym_fock_gap_of_band_and_tail

end Audit

end BookProof.TruncationGapLift

end
