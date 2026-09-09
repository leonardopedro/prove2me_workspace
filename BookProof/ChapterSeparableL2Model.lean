import BookProof.ChapterSeparableSpectrum

/-!
# A separably acting abelian algebra needs no metrizability hypothesis (plan GAP-2)

`ChapterStandardBorelClassification` classifies the summands of the general abelian
multiplication model under the hypothesis that the compact spectrum is metrizable, and
`ChapterSeparableSpectrum` identifies that hypothesis with separability of the algebra.
This module removes it in the remaining case of interest: when the algebra acts on a
**separable** Hilbert space, each summand `L²(μₓ)` is separable, and a separable `L²`
can always be transported to a standard Borel space, whatever the spectrum looks like.

* `exists_countable_dense_continuous` — if `L²(μ)` is separable then a *countable*
  family of continuous functions is already dense in it;
* `coordMap` — the map `y ↦ (f y)_{f ∈ D}` into the countable power `D → ℂ`, a Polish,
  hence standard Borel, space;
* `coordUnitary`, `coordUnitary_intertwines` — composition with `coordMap` is a
  **unitary** `L²(μ ∘ coordMap⁻¹) ≃ L²(μ)` (it is isometric, and its range is closed and
  contains the dense family), and it carries multiplication by `g` to multiplication by
  `g ∘ coordMap`;
* **HEADLINE** `separable_Lp_realizes_standard_type` — a Borel probability measure on a
  compact Hausdorff space with separable `L²` is unitarily a Borel probability measure
  on a standard Borel space, hence realises one of the five standard types;
* **HEADLINE** `abelian_multiplication_model_classified_separable_hilbert` — every
  abelian algebra of operators on a *separable* complex Hilbert space, presented as a
  unital `*`-representation of `C(Y, ℂ)` for a compact Hausdorff `Y`, is a countable
  direct sum of multiplication algebras, each of which realises one of the five standard
  types.  No metrizability, and no separability of the algebra, is assumed;
* **HEADLINE** `abelian_algebra_multiplication_model_classified_separable_hilbert` — the
  same statement for an abstract commutative unital C\*-algebra, through Gelfand duality.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory TopologicalSpace

namespace BookProof.ChapterSeparableL2Model

open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum BookProof.ChapterLinftyMultiplication
open BookProof.ChapterStandardBorelClassification

/-! ## 1. A countable dense family of continuous functions -/

section Dense

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]

/-- If `L²(μ)` is separable, a countable family of continuous functions is dense in it.
Continuous functions are dense (Riesz regularity), and a separable metric space needs
only countably many of them. -/
theorem exists_countable_dense_continuous [SeparableSpace (Lp ℂ 2 mu)] :
    ∃ D : Set C(Y, ℂ), D.Countable ∧
      Dense ((fun f : C(Y, ℂ) => ContinuousMap.toLp 2 mu ℂ f) '' D) := by
  classical
  obtain ⟨E, hEc, hEd⟩ := exists_countable_dense (Lp ℂ 2 mu)
  have hdense : DenseRange
      ((ContinuousMap.toLp 2 mu ℂ).toLinearMap : C(Y, ℂ) → Lp ℂ 2 mu) :=
    ContinuousMap.toLp_denseRange ℂ _ (μ := mu) (by simp)
  have hchoice : ∀ (v : Lp ℂ 2 mu) (n : ℕ), ∃ f : C(Y, ℂ),
      dist (ContinuousMap.toLp 2 mu ℂ f) v < 1 / (n + 1) := by
    intro v n
    obtain ⟨b, hb, hdb⟩ := Metric.mem_closure_iff.1 (hdense v) (1 / (n + 1)) (by positivity)
    obtain ⟨f, hf⟩ := hb
    exact ⟨f, by rw [← hf] at hdb; simpa [dist_comm] using hdb⟩
  choose g hg using hchoice
  haveI : Countable E := hEc.to_subtype
  refine ⟨Set.range fun p : E × ℕ => g (p.1 : Lp ℂ 2 mu) p.2, Set.countable_range _, ?_⟩
  rw [Metric.dense_iff]
  intro v ε hε
  obtain ⟨e, heE, hev⟩ := Metric.mem_closure_iff.1 (hEd v) (ε / 2) (by linarith)
  obtain ⟨n, hn⟩ := exists_nat_one_div_lt (show (0:ℝ) < ε / 2 by linarith)
  refine ⟨ContinuousMap.toLp 2 mu ℂ (g e n), ?_, ⟨g e n, ⟨(⟨e, heE⟩, n), rfl⟩, rfl⟩⟩
  refine Metric.mem_ball.2 ?_
  have h1 := hg e n
  have h0 : dist (ContinuousMap.toLp 2 mu ℂ (g e n)) v
      ≤ dist (ContinuousMap.toLp 2 mu ℂ (g e n)) e + dist e v := dist_triangle _ _ _
  have h2 : dist e v < ε / 2 := by simpa [dist_comm] using hev
  linarith

end Dense

/-! ## 2. The coordinate map into a countable power of `ℂ` -/

section Coord

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]

/-- The evaluation map `y ↦ (f y)_{f ∈ D}` into the countable power `D → ℂ`. -/
def coordMap : Y → (D → ℂ) := fun y d => (d : C(Y, ℂ)) y

omit [CompactSpace Y] [MeasurableSpace Y] [BorelSpace Y] [Countable D] in
theorem continuous_coordMap : Continuous (coordMap D) :=
  continuous_pi fun d => (d : C(Y, ℂ)).continuous

omit [CompactSpace Y] in
theorem measurable_coordMap : Measurable (coordMap D) :=
  (continuous_coordMap D).measurable

end Coord

/-! ## 3. Transporting a separable `L²` to a standard Borel space -/

section Transport

universe u

variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsProbabilityMeasure mu] [mu.WeaklyRegular]

/-- **HEADLINE.**  A Borel probability measure on a compact Hausdorff space whose `L²`
space is separable is carried, by a unitary intertwining the multiplication operators,
to a Borel probability measure on a *standard Borel* space — so it realises one of the
five standard types of the classification list, with no metrizability hypothesis on the
space it started on. -/
theorem separable_Lp_realizes_standard_type [SeparableSpace (Lp ℂ 2 mu)] :
    ∃ (Z : Type u) (_ : MeasurableSpace Z) (_ : StandardBorelSpace Z)
      (_ : MeasurableSingletonClass Z) (Phi : Y → Z) (hPhi : Measurable Phi),
      ∃ _ : IsProbabilityMeasure (Measure.map Phi mu),
        RealizesStandardType (Measure.map Phi mu) ∧
        ∃ U : Lp ℂ 2 (Measure.map Phi mu) ≃ₗᵢ[ℂ] Lp ℂ 2 mu,
          ∀ (g : Z → ℂ) (hg : MemLp g ⊤ (Measure.map Phi mu))
            (v : Lp ℂ 2 (Measure.map Phi mu)),
            U (multOp g hg v)
              = multOp (fun y => g (Phi y)) (hg.comp_measurePreserving ⟨hPhi, rfl⟩) (U v) := by
  classical
  obtain ⟨D, hDc, hDdense⟩ := exists_countable_dense_continuous mu
  haveI : Countable D := hDc.to_subtype
  haveI hborel : BorelSpace (∀ _ : D, ℂ) := Pi.borelSpace
  set Phi : Y → (D → ℂ) := coordMap D with hPhidef
  have hPhi : Measurable Phi := measurable_coordMap D
  have hmp : MeasurePreserving Phi mu (Measure.map Phi mu) := ⟨hPhi, rfl⟩
  haveI hprob : IsProbabilityMeasure (Measure.map Phi mu) :=
    Measure.isProbabilityMeasure_map hPhi.aemeasurable
  set L : Lp ℂ 2 (Measure.map Phi mu) →ₗᵢ[ℂ] Lp ℂ 2 mu :=
    Lp.compMeasurePreservingₗᵢ ℂ Phi hmp with hLdef
  have hLcoe : ∀ w : Lp ℂ 2 (Measure.map Phi mu),
      ((L w : Lp ℂ 2 mu) : Y → ℂ) =ᵐ[mu] fun y => (w : (D → ℂ) → ℂ) (Phi y) :=
    fun w => Lp.coeFn_compMeasurePreserving w hmp
  -- every member of the dense family is in the range of `L`, via its coordinate
  have hcoord : ∀ d : D, ∃ w : Lp ℂ 2 (Measure.map Phi mu),
      L w = ContinuousMap.toLp 2 mu ℂ (d : C(Y, ℂ)) := by
    intro d
    have hcontd : Continuous fun z : D → ℂ => z d := continuous_apply d
    have hcomp : (fun z : D → ℂ => z d) ∘ Phi = fun y => (d : C(Y, ℂ)) y := rfl
    have hmemY : MemLp (fun y => (d : C(Y, ℂ)) y) 2 mu :=
      (Lp.memLp (ContinuousMap.toLp 2 mu ℂ (d : C(Y, ℂ)))).ae_eq
        (ContinuousMap.coeFn_toLp mu (d : C(Y, ℂ)))
    have hmem : MemLp (fun z : D → ℂ => z d) 2 (Measure.map Phi mu) := by
      refine (memLp_map_measure_iff ?_ hPhi.aemeasurable).2 ?_
      · exact hcontd.aestronglyMeasurable
      · rw [hcomp]; exact hmemY
    refine ⟨hmem.toLp _, ?_⟩
    refine Lp.ext ?_
    have h1 := hLcoe (hmem.toLp _)
    have h2 := hmp.quasiMeasurePreserving.ae_eq_comp hmem.coeFn_toLp
    have h3 := ContinuousMap.coeFn_toLp (p := 2) (𝕜 := ℂ) mu (d : C(Y, ℂ))
    filter_upwards [h1, h2, h3] with y hy1 hy2 hy3
    simp only [Function.comp_apply] at hy1 hy2
    rw [hy1, hy2, hy3]
    rfl
  -- so the range of `L`, closed because `L` is an isometry of complete spaces, is
  -- everything
  have hsurj : Function.Surjective L := by
    have hclosed : IsClosed (Set.range L) :=
      (L.isometry.isClosedEmbedding).isClosed_range
    have hsub : (fun f : C(Y, ℂ) => ContinuousMap.toLp 2 mu ℂ f) '' D ⊆ Set.range L := by
      rintro _ ⟨f, hf, rfl⟩
      obtain ⟨w, hw⟩ := hcoord ⟨f, hf⟩
      exact ⟨w, hw⟩
    have hdenseR : Dense (Set.range L) := hDdense.mono hsub
    have : Set.range L = Set.univ := by
      rw [← hclosed.closure_eq, hdenseR.closure_eq]
    intro u
    have : u ∈ Set.range L := this ▸ Set.mem_univ u
    exact this
  refine ⟨D → ℂ, inferInstance, inferInstance, inferInstance, Phi, hPhi, hprob,
    standardBorel_classification_list _, LinearIsometryEquiv.ofSurjective L hsurj, ?_⟩
  intro g hg v
  refine Lp.ext ?_
  have h1 := hLcoe (multOp g hg v)
  have h2 := hmp.quasiMeasurePreserving.ae_eq_comp
    (multOp_coeFn (μ := Measure.map Phi mu) g hg v)
  have h3 := multOp_coeFn (μ := mu) (fun y => g (Phi y))
    (hg.comp_measurePreserving hmp) (L v)
  have h4 := hLcoe v
  filter_upwards [h1, h2, h3, h4] with y hy1 hy2 hy3 hy4
  simp only [Function.comp_apply] at hy1 hy2 hy4
  simp only [LinearIsometryEquiv.coe_ofSurjective]
  rw [hy1, hy2, hy3, hy4]

end Transport

/-! ## 4. An abelian algebra on a separable Hilbert space -/

section SeparableHilbert

universe u

variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

omit [CompleteSpace H] in
/-- A space that embeds isometrically in a separable normed space is separable. -/
theorem separableSpace_of_linearIsometry [SeparableSpace H] {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℂ E] (V : E →ₗᵢ[ℂ] H) : SeparableSpace E := by
  haveI : SecondCountableTopology H := UniformSpace.secondCountable_of_separable H
  haveI := (V.isometry.isEmbedding).secondCountableTopology
  infer_instance

/-- **HEADLINE (exhaustiveness for a separably acting abelian algebra).**  Every abelian
algebra of operators on a *separable* complex Hilbert space, presented as a unital
`*`-representation of `C(Y, ℂ)` for a compact Hausdorff `Y`, is a countable direct sum of
multiplication algebras, and each summand is unitarily a Borel probability measure on a
standard Borel space — so it realises one of the five standard types of the abelian
classification list.  Neither metrizability of `Y` nor separability of the algebra is
assumed: separability of the Hilbert space alone supplies the reduction, because each
summand `L²(μₓ)` is then separable and a countable family of continuous functions is
already dense in it. -/
theorem abelian_multiplication_model_classified_separable_hilbert [SeparableSpace H]
    (pi : C(Y, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure Y) (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      S.Countable ∧
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (g : C(Y, ℂ)) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) g u) = pi g (V x u)) ∧
      (∀ x : S, ∃ (Z : Type u) (_ : MeasurableSpace Z) (_ : StandardBorelSpace Z)
        (_ : MeasurableSingletonClass Z) (Phi : Y → Z) (hPhi : Measurable Phi),
        ∃ _ : IsProbabilityMeasure (Measure.map Phi (mu x)),
          RealizesStandardType (Measure.map Phi (mu x)) ∧
          ∃ U : Lp ℂ 2 (Measure.map Phi (mu x)) ≃ₗᵢ[ℂ] Lp ℂ 2 (mu x),
            ∀ (g : Z → ℂ) (hg : MemLp g ⊤ (Measure.map Phi (mu x)))
              (v : Lp ℂ 2 (Measure.map Phi (mu x))),
              U (multOp g hg v)
                = multOp (fun y => g (Phi y)) (hg.comp_measurePreserving ⟨hPhi, rfl⟩) (U v)) := by
  obtain ⟨S, hS, htop⟩ := exists_rep_cyclic_decomposition pi
  refine ⟨S, fun x => repMeasure pi (x : H), fun x => repEmbedding pi (x : H),
    countable_orthogonalRepCyclicFamily hS,
    fun x => isProbabilityMeasure_repMeasure pi (x : H) (hS.1 (x : H) x.2), ?_,
    fun x g u => repEmbedding_intertwines pi (x : H) g u, ?_⟩
  · refine IsHilbertSum.mk (orthogonalFamily_repEmbedding hS) ?_
    have hrange : (⨆ x : S, LinearMap.range (repEmbedding pi (x : H)).toLinearMap)
        = ⨆ x ∈ S, repCyclicSubspace pi x := by
      rw [iSup_subtype]
      exact iSup_congr fun x => iSup_congr fun _ => range_repEmbedding pi x
    rw [hrange, htop]
  · intro x
    haveI := isProbabilityMeasure_repMeasure pi (x : H) (hS.1 (x : H) x.2)
    haveI : SeparableSpace (Lp ℂ 2 (repMeasure pi (x : H))) :=
      separableSpace_of_linearIsometry (repEmbedding pi (x : H))
    exact separable_Lp_realizes_standard_type (repMeasure pi (x : H))

end SeparableHilbert

/-! ## 5. The Gelfand form on a separable Hilbert space -/

section GelfandSeparableHilbert

open WeakDual

universe v

variable {A : Type v} [CommCStarAlgebra A]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- **HEADLINE (the Gelfand form, separably acting).**  Every unital `*`-representation
of a commutative unital C\*-algebra on a *separable* complex Hilbert space is a countable
direct sum of multiplication representations — the algebra element `a` acting on the
summand as multiplication by its Gelfand transform — and each summand is unitarily a
Borel probability measure on a standard Borel space, so it realises one of the five
standard types.  Nothing is assumed about the character space. -/
theorem abelian_algebra_multiplication_model_classified_separable_hilbert
    [TopologicalSpace.SeparableSpace H] (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure (characterSpace ℂ A))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      S.Countable ∧
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (a : A) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (gelfandModel A a) u) = rho a (V x u)) ∧
      (∀ x : S, ∃ (Z : Type v) (_ : MeasurableSpace Z) (_ : StandardBorelSpace Z)
        (_ : MeasurableSingletonClass Z) (Phi : characterSpace ℂ A → Z)
        (hPhi : Measurable Phi),
        ∃ _ : IsProbabilityMeasure (Measure.map Phi (mu x)),
          RealizesStandardType (Measure.map Phi (mu x)) ∧
          ∃ U : Lp ℂ 2 (Measure.map Phi (mu x)) ≃ₗᵢ[ℂ] Lp ℂ 2 (mu x),
            ∀ (g : Z → ℂ) (hg : MemLp g ⊤ (Measure.map Phi (mu x)))
              (v : Lp ℂ 2 (Measure.map Phi (mu x))),
              U (multOp g hg v)
                = multOp (fun y => g (Phi y)) (hg.comp_measurePreserving ⟨hPhi, rfl⟩) (U v)) := by
  obtain ⟨S, mu, V, hcount, hprob, hsum, hint, hclass⟩ :=
    abelian_multiplication_model_classified_separable_hilbert (gelfandRep rho)
  refine ⟨S, mu, V, hcount, hprob, hsum, fun x a u => ?_, hclass⟩
  rw [hint x (gelfandModel A a) u, gelfandRep_gelfandModel]

end GelfandSeparableHilbert

end BookProof.ChapterSeparableL2Model

end
