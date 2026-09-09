import Mathlib
import BookProof.ChapterG

/-!
# Chapter B §§7–9 — Symmetries, conservative and deterministic transformations

This file formalizes work-package **N10** of `FORMALIZATION_ROADMAP.md`
(book lines 1857–2005). It builds on the Koopman unitary `koopmanEquiv` of
`BookProof.ChapterG` (G.7).

Sections:
* B7.1 the Koopman representation is functorial (symmetry groups act unitarily),
* B7.2 Koopman fixes constants (the vacuum/counting state),
* B7.3 deterministic transformations preserve the event algebra,
* B7.4 complementarity: a non-deterministic unitary (contrast).

Everything is `sorry`-free and `axiom`-free (no `EXTERNAL` hypothesis).
-/

open MeasureTheory
open scoped Matrix

namespace BookProof.ChapterB7

open BookProof.ChapterG

/-! ## B7.1 — The Koopman representation is functorial -/

section Functorial

variable {α β γ E : Type*} [MeasurableSpace α] [MeasurableSpace β] [MeasurableSpace γ]
  [NormedAddCommGroup E] [NormedSpace ℝ E]
  {μ : Measure α} {ν : Measure β} {ρ : Measure γ}
  {p : ENNReal} [Fact (1 ≤ p)]

/-
The Koopman assignment is (contravariantly) functorial in the
measure-preserving equivalence (book §7).
-/
theorem koopman_comp (f : α ≃ᵐ β) (g : β ≃ᵐ γ) (hf : MeasurePreserving f μ ν)
    (hg : MeasurePreserving g ν ρ) (hfg : MeasurePreserving (f.trans g) μ ρ)
    (u : Lp E p ρ) :
    koopmanEquiv f hf (koopmanEquiv g hg u) = koopmanEquiv (f.trans g) hfg u := by
  simp only [koopmanEquiv, LinearIsometryEquiv.coe_mk, LinearEquiv.coe_mk,
      LinearIsometry.coe_toLinearMap];
  refine Lp.ext ?_;
  have h_eq : (Lp.compMeasurePreservingₗᵢ ℝ (⇑f) hf) ((Lp.compMeasurePreservingₗᵢ ℝ (⇑g) hg) u)
      =ᵐ[μ] (fun x => u (g (f x))) := by
    have h_eq : (Lp.compMeasurePreservingₗᵢ ℝ (⇑g) hg) u =ᵐ[ν] (fun x => u (g x)) := by
      apply_rules [ Lp.coeFn_compMeasurePreserving ];
    have h_eq_comp : (Lp.compMeasurePreservingₗᵢ ℝ (⇑f) hf) ((Lp.compMeasurePreservingₗᵢ ℝ (⇑g) hg)
        u) =ᵐ[μ] (fun x => (Lp.compMeasurePreservingₗᵢ ℝ (⇑g) hg) u (f x)) := by
      convert Lp.coeFn_compMeasurePreserving ( Lp.compMeasurePreservingₗᵢ ℝ ( ⇑g ) hg u ) hf using
          1;
    filter_upwards [ h_eq_comp, hf.quasiMeasurePreserving.ae ( h_eq ) ] with x hx₁ hx₂ using
        by aesop;
  refine h_eq.trans ?_;
  convert ( Lp.coeFn_compMeasurePreserving ( u ) hfg ).symm using 1

/-
The Koopman unitary of the identity is the identity.
-/
theorem koopman_refl (h : MeasurePreserving (MeasurableEquiv.refl α) μ μ) (u : Lp E p μ) :
    koopmanEquiv (MeasurableEquiv.refl α) h u = u := by
  ext;
  -- The Koopman unitary of the identity equivalence is the identity operator.
  apply Lp.coeFn_compMeasurePreserving

end Functorial

/-
A measure-preserving action of a group yields a (contravariant) unitary
representation on wave-functions (book §7).
-/
theorem koopmanRep_mul {α E : Type*} [MeasurableSpace α]
    [NormedAddCommGroup E] [NormedSpace ℝ E] {μ : Measure α}
    {p : ENNReal} [Fact (1 ≤ p)]
    {G : Type*} [Group G] (r : G → (α ≃ᵐ α))
    (hr : ∀ g, MeasurePreserving (r g) μ μ)
    (hmul : ∀ g h, r (g * h) = (r g).trans (r h))
    (g h : G) (hgh : MeasurePreserving (r (g * h)) μ μ) (u : Lp E p μ) :
    koopmanEquiv (r (g * h)) hgh u
      = koopmanEquiv (r g) (hr g) (koopmanEquiv (r h) (hr h) u) := by
  convert ( koopman_comp ( r g ) ( r h ) ( hr g ) ( hr h ) ( by
    exact hmul g h ▸ hgh ) u ).symm;
  exact hmul g h

/-! ## B7.2 — Koopman fixes constants -/

/-
The Koopman unitary fixes the constants: the reference measure (the
"vacuum") is the fixed state of every conservative transformation (book §8).
-/
theorem koopman_const {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β]
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    {μ : Measure α} {ν : Measure β} [IsProbabilityMeasure μ] [IsProbabilityMeasure ν]
    {p : ENNReal} [Fact (1 ≤ p)]
    (f : α ≃ᵐ β) (hf : MeasurePreserving f μ ν) (c : E) :
    koopmanEquiv f hf (Lp.const p ν c) = Lp.const p μ c := by
  refine Lp.ext ?_;
  have h_const : (Lp.const p ν c : Lp E p ν) =ᵐ[ν] fun _ => c := by
    convert Lp.coeFn_const p ν c;
  have h_const_comp : (Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf (Lp.const p ν c) : Lp E p μ)
      =ᵐ[μ] fun _ => c := by
    have h_const_comp : (Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf (Lp.const p ν c) : Lp E p μ)
        =ᵐ[μ] (fun x => (Lp.const p ν c : Lp E p ν) (f x)) := by
      convert MeasureTheory.Lp.coeFn_compMeasurePreserving ( Lp.const p ν c ) hf using 1;
    filter_upwards [ h_const_comp, hf.preimage_null h_const ] with x hx₁ hx₂ using hx₁.trans hx₂;
  exact Filter.EventuallyEq.trans ‹_› ( h_const_comp.symm )

/-! ## B7.3 — Deterministic transformations preserve the event algebra -/

section EventAlgebra

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

/-- Preimage under a measure-preserving automorphism preserves measure. -/
theorem eventMap_measure (f : α ≃ᵐ α) (hf : MeasurePreserving f μ μ)
    {A : Set α} (hA : MeasurableSet A) : μ (f ⁻¹' A) = μ A :=
  hf.measure_preimage hA.nullMeasurableSet

/-- The event map respects intersection. -/
theorem eventMap_inter (f : α ≃ᵐ α) (A B : Set α) :
    f ⁻¹' (A ∩ B) = f ⁻¹' A ∩ f ⁻¹' B := Set.preimage_inter

/-- The event map respects union. -/
theorem eventMap_union (f : α ≃ᵐ α) (A B : Set α) :
    f ⁻¹' (A ∪ B) = f ⁻¹' A ∪ f ⁻¹' B := Set.preimage_union

/-- The event map respects complement. -/
theorem eventMap_compl (f : α ≃ᵐ α) (A : Set α) :
    f ⁻¹' Aᶜ = (f ⁻¹' A)ᶜ := Set.preimage_compl

/-
The event map is invertible: it is a Boolean automorphism.
-/
theorem eventMap_leftInverse (f : α ≃ᵐ α) (A : Set α) :
    f.symm ⁻¹' (f ⁻¹' A) = A := by
  ext x; simp 

end EventAlgebra

/-
Koopman conjugation sends indicators to indicators: deterministic
transformations keep the diagonal (event) algebra diagonal (book §9).
-/
theorem koopman_indicatorConstLp {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β]
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    {μ : Measure α} {ν : Measure β} {p : ENNReal} [Fact (1 ≤ p)]
    (f : α ≃ᵐ β) (hf : MeasurePreserving f μ ν)
    {A : Set β} (hA : MeasurableSet A) (hμA : ν A ≠ ⊤)
    (hA' : MeasurableSet (f ⁻¹' A)) (hμA' : μ (f ⁻¹' A) ≠ ⊤) (c : E) :
    koopmanEquiv f hf (indicatorConstLp p hA hμA c)
      = indicatorConstLp p hA' hμA' c := by
  exact SetLike.coe_eq_coe.mp rfl

/-! ## B7.4 — Complementarity: a non-deterministic unitary -/

/-- The normalized `2×2` Hadamard unitary (as in `ChapterE`). -/
noncomputable def hadamardU : Matrix (Fin 2) (Fin 2) ℂ :=
  (1 / Real.sqrt 2 : ℂ) • !![1, 1; 1, -1]

/-
**Complementarity (book §9).** There are diagonal (event) projections whose
Hadamard conjugates do not commute with them: the conjugating symmetry is not
deterministic. This is the quantum signature of complementarity.
-/
theorem hadamard_not_deterministic :
    ∃ P Q : Matrix (Fin 2) (Fin 2) ℂ, P * P = P ∧ Q * Q = Q ∧
      P * (hadamardU * Q * hadamardUᴴ) ≠ (hadamardU * Q * hadamardUᴴ) * P := by
  refine ⟨ Matrix.diagonal ( fun i ↦ if i = 0 then 1 else 0 ), Matrix.diagonal ( fun i ↦ if i = 0
      then 1 else 0 ), ?_, ?_, ?_ ⟩;
  · simp +zetaDelta at *;
  · aesop;
  · intro h;    have := congr_fun ( congr_fun h 0 ) 1;    norm_num [ Fin.sum_univ_succ,
      Fin.prod_univ_succ, Finset.sum_range_succ, Finset.prod_range_succ, hadamardU ] at this;
    simp [ Matrix.vecMul, dotProduct ] at this

end BookProof.ChapterB7
