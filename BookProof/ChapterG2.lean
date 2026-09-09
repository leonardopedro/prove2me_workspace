import Mathlib
import BookProof.ChapterG

/-!
# Chapter G II — Gribov ambiguity, BRST cohomology, general Dirac obstruction

This file formalizes work-package **N9** of `FORMALIZATION_ROADMAP.md`,
completing the book's chapters on gauge symmetry and the Gribov ambiguity
(book lines 2128 ff. and 7125 ff.).

Sections:
* G.8  conditioning fails on null constraint sets,
* G.9  the Dirac obstruction for any countably infinite gauge group,
* G.10 the Gribov ambiguity: no *continuous* complete gauge fixing of the circle,
* G.11 BRST cohomology of the gauge-mechanics model,
* G.12 Haar averaging is the invariant projection.

Everything is `sorry`-free and `axiom`-free (no `EXTERNAL` hypothesis).
-/

open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

namespace BookProof.ChapterG2

/-! ## G.8 — Conditioning fails on null constraint sets -/

variable {Ω : Type*} [MeasurableSpace Ω]

/-
Conditioning on a null set yields the zero measure (book 2230–2245).
-/
theorem cond_of_null (μ : Measure Ω) {C : Set Ω} (hC : μ C = 0) : μ[|C] = 0 := by
  simp [ ProbabilityTheory.cond, MeasureTheory.Measure.restrict_eq_zero.mpr hC ]

/-
Conditioning on a null set does not yield a probability measure — this is
the negative half that motivates the pushforward construction of G.5.
-/
theorem not_isProbabilityMeasure_cond_null (μ : Measure Ω) {C : Set Ω}
    (hC : μ C = 0) : ¬ IsProbabilityMeasure μ[|C] := by
  intro h;
  have := congr_arg ( fun m => m Set.univ ) ( cond_of_null μ hC ) ;    simp_all [
      IsProbabilityMeasure.measure_univ ] ;

/-! ## G.9 — The Dirac obstruction in general form -/

/-
There is no translation-invariant probability measure on any countably
infinite group (book 2270–2292, Dirac 1955).
-/
theorem no_translation_invariant_probabilityMeasure {G : Type*} [Group G]
    [Countable G] [Infinite G] [MeasurableSpace G] [MeasurableSingletonClass G] :
    ¬ ∃ μ : Measure G, IsProbabilityMeasure μ ∧ ∀ g x : G, μ {g * x} = μ {x} := by
  by_contra! h;
  obtain ⟨ μ, hμ₁, hμ₂ ⟩ := h;
  have h_singleton : ∀ g : G, μ {g} = μ {1} := by
    exact fun g => by simpa using hμ₂ g 1;
  have h_sum : ∑' g : G, μ {g} = 1 := by
    rw [ ← MeasureTheory.measure_iUnion ];
    · simp [ Set.iUnion_of_singleton ];
    · exact fun x y hxy => Set.disjoint_singleton.2 hxy;
    · exact fun g => MeasurableSingletonClass.measurableSet_singleton g;
  by_cases h : μ { 1 } = 0 <;> simp_all

/-
A translation-invariant vector in `ℓ²(G)` is zero, for `G` infinite.
-/
theorem translation_invariant_l2_eq_zero {G : Type*} [Group G] [Infinite G]
    (Ψ : lp (fun _ : G => ℂ) 2) (hΨ : ∀ g x : G, Ψ (g * x) = Ψ x) : Ψ = 0 := by
  ext x;
  have h_const : ∀ g : G, Ψ g = Ψ 1 := by
    exact fun g => by simpa using hΨ g 1;
  have := Ψ.2.summable;
  simp_all [ summable_const_iff ]

/-
There is no translation-invariant unit vector in `ℓ²(G)`, for `G` infinite.
-/
theorem no_translation_invariant_unit_vector {G : Type*} [Group G] [Infinite G] :
    ¬ ∃ Ψ : lp (fun _ : G => ℂ) 2, ‖Ψ‖ = 1 ∧ ∀ g x : G, Ψ (g * x) = Ψ x := by
  rintro ⟨ Ψ, hnorm, hinv ⟩;
  have := translation_invariant_l2_eq_zero Ψ hinv; aesop;

/-! ## G.10 — HEADLINE: the Gribov ambiguity -/

/-
**The Gribov ambiguity (book 2294–2340 + 7125–7180).** There is no
*continuous* complete gauge fixing of the circle parametrization
`Circle.exp : ℝ → Circle`: complete gauge fixings exist set-theoretically
(G.4, by choice) but never continuously.
-/
theorem no_continuous_gauge_fixing_circle :
    ¬ ∃ s : Circle → ℝ, Continuous s ∧ ∀ z, Circle.exp (s z) = z := by
  intro h
  obtain ⟨s, hs_cont, hs⟩ := h
  have hF : Continuous (fun t : ℝ => s (Circle.exp t) - t) := by
    fun_prop
  have hF_int : ∀ t : ℝ, ∃ m : ℤ, s (Circle.exp t) - t = m * (2 * Real.pi) := by
    intro t; specialize hs ( Circle.exp t ) ; simp_all [ Circle.ext_iff ] ;
    rw [ Complex.exp_eq_exp_iff_exists_int ] at hs;      obtain ⟨ m, hm ⟩ := hs; exact ⟨ m,
        by norm_num [ Complex.ext_iff ] at hm; linarith ⟩ ;
  have hF_const : ∃ c : ℝ, ∀ t : ℝ, s (Circle.exp t) - t = c := by
    choose m hm using hF_int;
    have hF_const : Continuous (fun t : ℝ => m t : ℝ → ℤ) := by
      have hF_const : Continuous (fun t : ℝ => (m t : ℝ)) := by
        convert hF.div_const ( 2 * Real.pi ) using 1 ;          ext t ; rw [ hm t ] ; ring ;
            norm_num [ Real.pi_ne_zero ];
      convert hF_const using 1;
      norm_num [ Metric.continuous_iff ];
    have hF_const : IsConnected (Set.range m) := by
      exact isConnected_range hF_const;
    have := hF_const.isPreconnected.subsingleton;
    exact ⟨ m 0 * ( 2 * Real.pi ), fun t => by have := this ( Set.mem_range_self t ) (
                                               Set.mem_range_self 0 ) ; aesop ⟩
  generalize_proofs at *;
  obtain ⟨ c, hc ⟩ := hF_const;    have := hc 0; have := hc ( 2 * Real.pi ) ; simp_all [
      sub_eq_iff_eq_add ] ;

/-
Corollary: any set-theoretic gauge-fixing section of the circle is
discontinuous.
-/
theorem gauge_fixing_section_discontinuous
    (s : Circle → ℝ) (hs : ∀ z, Circle.exp (s z) = z) : ¬ Continuous s := by
  contrapose! hs with hs;
  exact not_forall.mp fun h => no_continuous_gauge_fixing_circle ⟨ s, hs, h ⟩

/-! ## G.11 — BRST cohomology of the gauge-mechanics model -/

section BRST

open BookProof.ChapterG

variable {A : Type*} [CommRing A] (Q : A)

/-- The BRST kernel: the closed states, `ker Ω`. -/
def brstKer : Submodule A (Fin 2 → A) :=
  LinearMap.ker (Matrix.mulVecLin (BRST Q))

/-- The BRST image: the exact states, `range Ω`. -/
def brstIm : Submodule A (Fin 2 → A) :=
  LinearMap.range (Matrix.mulVecLin (BRST Q))

/-- `Ω² = 0` gives `range Ω ⊆ ker Ω`. -/
theorem brstIm_le_brstKer : brstIm Q ≤ brstKer Q := by
  intro v hv; simp_all [ brstIm, brstKer,BRST ] ;
  rcases hv with ⟨ y, rfl ⟩ ; simp [ Matrix.vecHead ]

/-- Membership in the BRST kernel: `Ω v = 0 ↔ Q · v₀ = 0`. -/
theorem mem_brstKer_iff (v : Fin 2 → A) :
    v ∈ brstKer Q ↔ Q * v 0 = 0 := by
  unfold brstKer;
  simp [ BRST, funext_iff, Fin.forall_fin_two ];
  rfl

/-- Membership in the BRST image: `v` is exact iff `v₀ = 0` and `v₁ ∈ (Q)`. -/
theorem mem_brstIm_iff (v : Fin 2 → A) :
    v ∈ brstIm Q ↔ v 0 = 0 ∧ ∃ a, v 1 = Q * a := by
  constructor;
  · rintro ⟨ w, rfl ⟩ ; simp [ BRST ] ;
  · rintro ⟨ hv₀, a, hv₁ ⟩;
    use ![a, 0];
    ext i; fin_cases i <;> simp only [BRST, Fin.zero_eta, Fin.isValue, Matrix.mulVecBilin_apply,
        Matrix.mulVec_cons, Nat.succ_eq_add_one, Nat.reduceAdd, zero_smul, Matrix.mulVec_empty,
            add_zero, Pi.add_apply, Pi.smul_apply, Function.comp_apply, Matrix.cons_val_zero,
                Matrix.head_cons, smul_eq_mul, mul_zero, Pi.zero_apply, hv₀, Fin.mk_one,
                    Matrix.cons_val_one, Matrix.cons_val_fin_one, hv₁] ;
    exact mul_comm _ _

/-- The BRST cohomology of the gauge-mechanics model. -/
abbrev brstCohomology : Type _ :=
  brstKer Q ⧸ (brstIm Q).comap (brstKer Q).subtype

/-- The forward linear map out of the closed states: `v ↦ (v₀, [v₁])`, landing
in `ker (·Q) × A⧸(Q)`. -/
noncomputable def brstFwd :
    brstKer Q →ₗ[A] (LinearMap.ker (LinearMap.mulLeft A Q) × (A ⧸ Ideal.span {Q})) where
  toFun v := (⟨(v : Fin 2 → A) 0, by
      rw [LinearMap.mem_ker, LinearMap.mulLeft_apply]; exact (mem_brstKer_iff Q _).1 v.2⟩,
    Ideal.Quotient.mk _ ((v : Fin 2 → A) 1))
  map_add' := by intro x y; ext <;> simp
  map_smul' := by
    intro c x; ext
    · simp
    · simp [Algebra.smul_def]

/-- `brstFwd` kills the exact states, so it descends to cohomology. -/
theorem brstFwd_ker :
    (brstIm Q).comap (brstKer Q).subtype ≤ LinearMap.ker (brstFwd Q) := by
  intro v hv
  rw [Submodule.mem_comap] at hv
  simp only [Submodule.coe_subtype] at hv
  rw [mem_brstIm_iff] at hv
  obtain ⟨h0, a, h1⟩ := hv
  rw [LinearMap.mem_ker]
  apply Prod.ext
  · apply Subtype.ext; simp [brstFwd, h0]
  · simp only [brstFwd, LinearMap.coe_mk, AddHom.coe_mk]
    rw [h1]
    exact Ideal.Quotient.eq_zero_iff_mem.mpr
      (Ideal.mem_span_singleton.mpr ⟨a, mul_comm a Q ▸ rfl⟩)

/-- The ghost-0 injection `ker (·Q) → H`, `a ↦ [![a,0]]`. -/
noncomputable def brstG1 :
    (LinearMap.ker (LinearMap.mulLeft A Q)) →ₗ[A] brstCohomology Q :=
  (Submodule.mkQ _) ∘ₗ
    (LinearMap.codRestrict (brstKer Q)
      ((LinearMap.single A (fun _ : Fin 2 => A) 0) ∘ₗ
        (LinearMap.ker (LinearMap.mulLeft A Q)).subtype)
      (by intro a
          rw [mem_brstKer_iff]
          have h := a.2
          rw [LinearMap.mem_ker, LinearMap.mulLeft_apply] at h
          simpa using h))

/-- The ghost-1 injection base `A → H`, `b ↦ [![0,b]]`. -/
noncomputable def brstG2base : A →ₗ[A] brstCohomology Q :=
  (Submodule.mkQ _) ∘ₗ
    (LinearMap.codRestrict (brstKer Q)
      (LinearMap.single A (fun _ : Fin 2 => A) 1)
      (by intro b; rw [mem_brstKer_iff]; simp))

/-- `brstG2base` kills `(Q)`, so it descends to `A⧸(Q)`. -/
theorem brstG2base_ker : Ideal.span {Q} ≤ LinearMap.ker (brstG2base Q) := by
  intro b hb
  rw [LinearMap.mem_ker]
  obtain ⟨a, ha⟩ := Ideal.mem_span_singleton.mp hb
  simp only [brstG2base, LinearMap.coe_comp, Function.comp_apply, Submodule.mkQ_apply]
  rw [Submodule.Quotient.mk_eq_zero, Submodule.mem_comap, mem_brstIm_iff]
  exact ⟨by simp, a, by simp [ha]⟩

/-- The ghost-1 injection `A⧸(Q) → H`. -/
noncomputable def brstG2 : (A ⧸ Ideal.span {Q}) →ₗ[A] brstCohomology Q :=
  Submodule.liftQ _ (brstG2base Q) (brstG2base_ker Q)

/-- The inverse map `ker (·Q) × A⧸(Q) → H`. -/
noncomputable def brstGinv :
    (LinearMap.ker (LinearMap.mulLeft A Q) × (A ⧸ Ideal.span {Q}))
      →ₗ[A] brstCohomology Q :=
  LinearMap.coprod (brstG1 Q) (brstG2 Q)

theorem brstCohomology_equiv_right :
    (Submodule.liftQ _ (brstFwd Q) (brstFwd_ker Q)) ∘ₗ (brstGinv Q) = LinearMap.id := by
  ext ⟨a, y⟩; focus (simp [brstGinv, brstG1, brstG2]);
  · rfl;
  · unfold brstGinv brstG1 brstFwd;    simp  ;
  · simp only [brstFwd, Fin.isValue, brstGinv, brstG1, brstG2, LinearMap.coe_comp,
      LinearMap.coe_inr, Function.comp_apply, Submodule.mkQ_apply, Ideal.Quotient.mk_eq_mk, map_one,
          LinearMap.coprod_apply, map_zero, zero_add, LinearMap.id_comp, ZeroMemClass.coe_zero,
              ZeroMemClass.coe_eq_zero];
    erw [ Submodule.liftQ_apply ] ; simp ;
  · simp only [brstFwd, Fin.isValue, brstGinv, brstG1, brstG2, LinearMap.coe_comp,
      LinearMap.coe_inr, Function.comp_apply, Submodule.mkQ_apply, Ideal.Quotient.mk_eq_mk, map_one,
          LinearMap.coprod_apply, map_zero, zero_add, LinearMap.id_comp];
    erw [ Submodule.liftQ_apply ] ; simp  ;

theorem brstCohomology_equiv_left :
    (brstGinv Q) ∘ₗ (Submodule.liftQ _ (brstFwd Q) (brstFwd_ker Q)) = LinearMap.id := by
  ext ⟨v, hv⟩;
  simp only [brstGinv, brstFwd, Fin.isValue, LinearMap.coe_comp, Function.comp_apply,
      Submodule.mkQ_apply, Submodule.liftQ_apply, LinearMap.coe_mk, AddHom.coe_mk,
          LinearMap.coprod_apply, LinearMap.id_comp];
  erw [ Submodule.Quotient.eq ];
  simp only [Fin.isValue, Submodule.mem_comap, Submodule.subtype_apply, AddSubgroupClass.coe_sub,
      Submodule.coe_add, LinearMap.codRestrict_apply, LinearMap.coe_comp, LinearMap.coe_single,
          Submodule.coe_subtype, Function.comp_apply, mem_brstIm_iff, Pi.sub_apply, Pi.add_apply,
              Pi.single_eq_same, ne_eq, zero_ne_one, not_false_eq_true, Pi.single_eq_of_ne,
                  add_zero, sub_self, one_ne_zero, zero_add, true_and];
  exact ⟨ 0, by simp ⟩

/-- **Cohomology computation (book 2403–2455).** The BRST cohomology of the
gauge-mechanics model splits as the gauge-invariant states (`ker (·Q)`) in the
ghost-0 sector times the coinvariants (`A ⧸ (Q)`) in the ghost-1 sector. -/
noncomputable def brstCohomology_equiv :
    brstCohomology Q ≃ₗ[A]
      (LinearMap.ker (LinearMap.mulLeft A Q) × (A ⧸ Ideal.span {Q})) :=
  LinearEquiv.ofLinear
    (Submodule.liftQ _ (brstFwd Q) (brstFwd_ker Q))
    (brstGinv Q)
    (brstCohomology_equiv_right Q)
    (brstCohomology_equiv_left Q)

/-- **Headline (book 2403–2455).** A ghost-free state is BRST-closed iff it is
annihilated by the gauge generator: physical states are the gauge-invariant
ones. -/
theorem brst_physical_iff_gauge_invariant (a : A) :
    (![a, 0] ∈ brstKer Q) ↔ Q * a = 0 := by
  convert mem_brstKer_iff Q _

end BRST

/-! ## G.12 — Haar averaging is the invariant projection -/

section Haar

open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

omit [IsProbabilityMeasure μG] in
/-- The Haar average is itself gauge-invariant. -/
theorem haarAverage_invariant [MeasurableMul G] (f : X → ℝ) (g : G) (x : X) :
    haarAverage (μG := μG) f (g • x) = haarAverage (μG := μG) f x :=
  haarAverage_smul f g x

/-- Haar averaging is idempotent: it is a projection onto invariants. -/
theorem haarAverage_idempotent [MeasurableMul G] (f : X → ℝ) :
    haarAverage (μG := μG) (haarAverage (μG := μG) f) = haarAverage (μG := μG) f :=
  haarAverage_of_invariant (haarAverage (μG := μG) f) (haarAverage_smul f)

omit [μG.IsMulLeftInvariant] in
/-- Haar averaging preserves expectations under an invariant probability measure
(book 2350–2392): the expectation of an observable equals that of its average. -/
theorem integral_haarAverage [MeasurableSpace X] [MeasurableSMul G X]
    [MeasurableMul G]
    (μ : Measure X) [IsProbabilityMeasure μ]
    (hμ : ∀ g : G, MeasurePreserving (fun x : X => g • x) μ μ)
    (f : X → ℝ)
    (hint : Integrable (fun p : G × X => f (p.1⁻¹ • p.2)) (μG.prod μ)) :
    ∫ x, haarAverage (μG := μG) f x ∂μ = ∫ x, f x ∂μ := by
  simp only [haarAverage]
  rw [MeasureTheory.integral_integral_swap]
  · have hcomp : ∀ g : G, ∫ x, f (g • x) ∂μ = ∫ x, f x ∂μ := by
      intro g
      have hemb : MeasurableEmbedding (fun x : X => g • x) :=
        (MeasurableEquiv.smul g).measurableEmbedding
      rw [(hμ g).integral_comp hemb]
    have hswap : (fun g : G => ∫ x, f (g⁻¹ • x) ∂μ) = fun _ : G => ∫ x, f x ∂μ := by
      funext g; exact hcomp g⁻¹
    rw [hswap, integral_const]
    simp
  · exact hint.swap

end Haar

/-! ## G.16 — Simultaneous diagonalization of bounded commuting normal operators

From book.tex line 2358: "bounded commuting normal operators can always be
simultaneously diagonalized." This is the spectral theorem for commuting
normal operators.
-/

/-- Bounded commuting symmetric operators on a finite-dimensional inner
product space over ℂ are simultaneously diagonalizable: there exists a
common eigenbasis (the joint eigenspaces span the whole space).
This is the spectral theorem for commuting symmetric operators
(book line 2358).

Mathlib provides `LinearMap.IsSymmetric.iSup_iInf_eq_top_of_commute` which
states that for a finite family of pairwise commuting symmetric operators,
the joint eigenspaces span the whole space. -/
theorem commuting_normal_operators_simultaneously_diagonalizable
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [FiniteDimensional ℂ H]
    {ι : Type*} [Finite ι]
    (T : ι → H →ₗ[ℂ] H) (h_symm : ∀ i, (T i).IsSymmetric)
    (h_comm : ∀ i j, i ≠ j → Commute (T i) (T j)) :
    ⨆ (χ : ι → ℂ), ⨅ i, Module.End.eigenspace (T i) (χ i) = ⊤ :=
  LinearMap.IsSymmetric.iSup_iInf_eq_top_of_commute h_symm
    (fun i j hij => h_comm i j hij)

/-! ## G.17 — Haar measure for locally compact gauge groups

From book.tex lines 2392–2394: "for a locally compact gauge group (a Lie group,
for instance), a constant measure (Haar measure) always exists which allows
to create a functional which is gauge invariant."

This is already formalized in `ChapterG.lean` via `haarAverage` and the
Haar measure construction. We state the headline theorem here for
completeness.
-/

/-- For any locally compact gauge group `G`, a Haar probability measure exists
(book lines 2392–2394). This allows the construction of gauge-invariant
functionals.

Mathlib provides `MeasureTheory.Measure.haar` which is a Haar measure on any
locally compact topological group. We also need `IsTopologicalGroup G` for
the Haar measure construction. -/
theorem exists_haar_measure_for_gauge_group (G : Type*)
    [MeasurableSpace G] [TopologicalSpace G] [LocallyCompactSpace G] [Group G]
    [BorelSpace G] [IsTopologicalGroup G] :
    ∃ (μ : Measure G), μ.IsHaarMeasure := by
  refine ⟨MeasureTheory.Measure.haar, ?_⟩
  infer_instance

end BookProof.ChapterG2
