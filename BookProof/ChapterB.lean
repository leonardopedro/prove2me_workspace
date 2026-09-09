import Mathlib

/-!
# Chapter B — Wave-function parametrization of a probability measure

Formalization of the headline result of Chapter B of `book.tex`
(see `FORMALIZATION_ROADMAP.md` §B): every probability density is the Born rule
`|Ψ|²` of a unit vector `Ψ ∈ L²`, and conversely; and a unit vector is the image
of a basis vector under a unitary (`Ψ = 𝒰 e₀`).
-/

open MeasureTheory
open scoped ENNReal

namespace BookProof.ChapterB

universe u

/-
**Theorem B.1 (forward / square root).** For every probability density `p`
(measurable, nonnegative, integral `1`) there is a unit vector `Ψ ∈ L²` with
`|Ψ|² = p` almost everywhere. One may take `Ψ = √p`.
-/
theorem born_forward {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (p : α → ℝ) (hmeas : Measurable p) (hnonneg : ∀ x, 0 ≤ p x)
    (hint : ∫ x, p x ∂μ = 1) :
    ∃ Ψ : Lp ℂ 2 μ, ‖Ψ‖ = 1 ∧ ∀ᵐ x ∂μ, ‖(Ψ : α → ℂ) x‖ ^ 2 = p x := by
  -- Let `f : α → ℂ := fun x => ((Real.sqrt (p x) : ℝ) : ℂ)`.
  set f : α → ℂ := fun x => Complex.ofReal (Real.sqrt (p x)) with hf_def;
  -- By definition of $f$, we know that $f \in L^2(\alpha, \mathbb{C})$.
  have hf_L2 : MemLp f 2 μ := by
    rw [ MeasureTheory.memLp_two_iff_integrable_sq_norm ];
    · convert MeasureTheory.integrable_of_integral_eq_one ‹_›;
      simp [ hf_def, Real.sq_sqrt ( hnonneg _ ) ];
    · exact Complex.continuous_ofReal.comp_aestronglyMeasurable (
        Real.continuous_sqrt.comp_aestronglyMeasurable hmeas.aestronglyMeasurable );
  refine ⟨ hf_L2.toLp f, ?_, ?_ ⟩ <;> simp_all only [Lp.norm_toLp];
  · simp_all [ eLpNorm_eq_lintegral_rpow_enorm_toReal ];
    -- Since $|f(x)|^2 = p(x)$, we have $\int |f(x)|^2 \, d\mu = \int p(x) \, d\mu = 1$.
    have h_integral : ∫⁻ x, ‖f x‖ₑ ^ 2 ∂μ = ENNReal.ofReal (∫ x, p x ∂μ) := by
      rw [ MeasureTheory.ofReal_integral_eq_lintegral_ofReal ];
      · refine MeasureTheory.lintegral_congr fun x => ?_;
        erw [ ENNReal.coe_inj ] ; aesop;
      · exact MeasureTheory.integrable_of_integral_eq_one ‹_›;
      · exact Filter.Eventually.of_forall hnonneg;
    aesop;
  · filter_upwards [ MeasureTheory.MemLp.coeFn_toLp hf_L2 ] with x hx using by aesop;

/-
**Theorem B.1 (backward / Born rule).** For every unit vector `Ψ ∈ L²`, the
function `p = |Ψ|²` is a probability density: nonnegative with integral `1`.
-/
theorem born_backward {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (Ψ : Lp ℂ 2 μ) (hΨ : ‖Ψ‖ = 1) :
    (∀ x, 0 ≤ ‖(Ψ : α → ℂ) x‖ ^ 2) ∧ ∫ x, ‖(Ψ : α → ℂ) x‖ ^ 2 ∂μ = 1 := by
  convert hΨ using 1;
  norm_num [ MeasureTheory.Lp.norm_def, MeasureTheory.eLpNorm_eq_lintegral_rpow_enorm_toReal ];
  rw [ MeasureTheory.integral_eq_lintegral_of_nonneg_ae ];
  · rw [ ← ENNReal.toReal_rpow ] ; norm_num [ ← ENNReal.ofReal_coe_nnreal ];
    rw [ ← Real.sqrt_eq_rpow, Real.sqrt_eq_one ];
  · exact Filter.Eventually.of_forall fun x => sq_nonneg _;
  · exact MeasureTheory.AEStronglyMeasurable.pow ( MeasureTheory.Lp.aestronglyMeasurable _ |> fun h
      => h.norm ) _

/-
**Theorem B.2 (unit vector extends to a unitary).** Every unit vector `Ψ` in a
complex Hilbert space is the image of a basis vector under a unitary: it belongs
to some Hilbert basis. This is the book's `Ψ = 𝒰 e₀`.
-/
theorem unit_vector_extends {H : Type u} [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] [CompleteSpace H] (Ψ : H) (hΨ : ‖Ψ‖ = 1) :
    ∃ (ι : Type u) (b : HilbertBasis ι ℂ H) (i : ι), b i = Ψ := by
  obtain ⟨w, b, hsw, hb⟩ : ∃ (w : Set H) (b : HilbertBasis w ℂ H), {Ψ} ⊆ w ∧ ⇑b = Subtype.val := by
    have h_orthonormal : Orthonormal ℂ (Subtype.val : ({Ψ} : Set H) → H) := by
      simp [ Orthonormal, hΨ ]
    obtain ⟨w, b, hsw, hb⟩ : ∃ (w : Set H) (b : HilbertBasis w ℂ H), {Ψ} ⊆ w ∧ ⇑b = Subtype.val :=
        by
      have := h_orthonormal.exists_hilbertBasis_extension
      exact this;
    use w, b;
  exact ⟨ _, b, ⟨ Ψ, hsw rfl ⟩, hb ▸ rfl ⟩

/-
**Corollary B.2′ (regular conditional density / disintegration).** On a standard
Borel space the joint probability measure `ρ` on `X × Y` induced by a Born density
`p = |Ψ|²` admits a regular conditional probability: `ρ` factors as the
composition-product of its `X`-marginal `ρ.fst` with the conditional kernel
`ρ.condKernel` (the book's `p(y|x)`).  This is Mathlib's disintegration for
standard Borel spaces; no external theorem is required.
-/
theorem condKernel_disintegration {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
    [StandardBorelSpace Y] [Nonempty Y] (ρ : Measure (X × Y)) [IsProbabilityMeasure ρ] :
    ρ.fst.compProd ρ.condKernel = ρ :=
  Measure.disintegrate ρ ρ.condKernel

end BookProof.ChapterB
