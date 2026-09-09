import BookProof.ChapterDiffuseCdfModel
import BookProof.ChapterLinftyMultiplication

/-!
# The diffuse summand is multiplication on `L²[0,1]` (plan GAP-2)

`ChapterDiffuseCdfModel` shows that the distribution function `F = cdf μ` of an
atomless Borel probability measure on `ℝ` pushes `μ` forward to Lebesgue measure on
the unit interval.  Here that measure-level statement is upgraded to the operator
level, which is what the classification list actually asserts about the diffuse
type:

* `cdfComp` — composition with `F` is a linear isometry `L²[0,1] → L²(μ)`;
* `measureDense_cdfAlgebra` — the sets that agree with an `F`-preimage up to a
  `μ`-null set form a measure-dense set algebra generating the Borel sets, because
  every half line `(-∞, x]` is one of them;
* `cdfRange_eq_top` — consequently `cdfComp` is onto;
* HEADLINE `diffuse_multiplication_model_uniform` — **a diffuse probability measure
  gives the same multiplication algebra as the uniform measure**: there is a unitary
  `L²[0,1] ≃ L²(μ)` carrying multiplication by `g` to multiplication by `g ∘ F`.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory ProbabilityTheory Filter

namespace BookProof.ChapterDiffuseUnitaryModel

open BookProof.ChapterDiffuseCdfModel BookProof.ChapterLinftyMultiplication

/-! ## 1. The uniform measure on the unit interval -/

instance isProbabilityMeasure_volume_Icc :
    IsProbabilityMeasure (volume.restrict (Set.Icc (0 : ℝ) 1)) := by
  constructor
  simp [Real.volume_Icc]

variable (mu : Measure ℝ) [IsProbabilityMeasure mu] [NoAtoms mu]

omit [IsProbabilityMeasure mu] [NoAtoms mu] in
theorem measurable_cdf : Measurable (cdf mu) := (cdf mu).mono.measurable

/-- **The distribution function is measure preserving** from `μ` to the uniform
measure on `[0, 1]`. -/
theorem measurePreserving_cdf :
    MeasurePreserving (cdf mu) mu (volume.restrict (Set.Icc (0 : ℝ) 1)) :=
  ⟨measurable_cdf mu, map_cdf_eq_volume_Icc mu⟩

/-! ## 2. Composition with the distribution function -/

/-- **Composition with the distribution function**, a linear isometry from the `L²`
space of the uniform measure to the `L²` space of `μ`. -/
def cdfComp : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1)) →ₗᵢ[ℂ] Lp ℂ 2 mu :=
  Lp.compMeasurePreservingₗᵢ ℂ (cdf mu) (measurePreserving_cdf mu)

theorem cdfComp_coeFn (f : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    (cdfComp mu f : ℝ → ℂ) =ᵐ[mu] fun x => (f : ℝ → ℂ) (cdf mu x) :=
  Lp.coeFn_compMeasurePreserving f (measurePreserving_cdf mu)

/-- The range of `cdfComp`, as a submodule of `L²(μ)`. -/
def cdfRange : Submodule ℂ (Lp ℂ 2 mu) := LinearMap.range (cdfComp mu).toLinearMap

theorem isClosed_cdfRange : IsClosed (cdfRange mu : Set (Lp ℂ 2 mu)) := by
  have h : IsComplete (⇑(cdfComp mu) '' Set.univ) :=
    (LinearIsometry.isComplete_image_iff (cdfComp mu)).2 complete_univ
  rw [Set.image_univ] at h
  simpa [cdfRange] using h.isClosed

/-- Composition with `F` turns the indicator of `B` into the indicator of `F⁻¹(B)`. -/
theorem cdfComp_indicatorConstLp {B : Set ℝ} (hB : MeasurableSet B) (c : ℂ) :
    cdfComp mu (indicatorConstLp 2 hB (measure_ne_top _ B) c) =
      indicatorConstLp 2 (hB.preimage (measurable_cdf mu)) (measure_ne_top mu _) c := by
  refine Lp.ext ?_
  have h1 := cdfComp_coeFn mu (indicatorConstLp 2 hB (measure_ne_top _ B) c)
  have h2 :
      ((indicatorConstLp 2 hB
          (measure_ne_top (volume.restrict (Set.Icc (0 : ℝ) 1)) B) c : ℝ → ℂ))
        =ᵐ[volume.restrict (Set.Icc (0 : ℝ) 1)] B.indicator (fun _ => c) :=
    indicatorConstLp_coeFn
  have h3 := (measurePreserving_cdf mu).quasiMeasurePreserving.ae_eq_comp h2
  have h4 :
      ((indicatorConstLp 2 (hB.preimage (measurable_cdf mu))
          (measure_ne_top mu _) c : ℝ → ℂ))
        =ᵐ[mu] ((cdf mu) ⁻¹' B).indicator (fun _ => c) :=
    indicatorConstLp_coeFn
  filter_upwards [h1, h3, h4] with x hx1 hx3 hx4
  rw [hx1, hx4]
  have hx3' := hx3
  simp only [Function.comp_apply] at hx3'
  rw [hx3']
  rfl

/-! ## 3. Half lines are `F`-preimages up to a null set -/

/-- The sublevel sets of the distribution function, for every level in `[0, 1]`. -/
theorem measure_cdf_le' {t : ℝ} (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    mu {x | cdf mu x ≤ t} = ENNReal.ofReal t := by
  rcases lt_or_eq_of_le ht1 with h | h
  · exact measure_cdf_le mu ht0 h
  · have huniv : {x : ℝ | cdf mu x ≤ t} = Set.univ := by
      ext x
      simp only [Set.mem_setOf_eq, Set.mem_univ, iff_true]
      rw [h]
      exact cdf_le_one mu x
    rw [huniv, measure_univ, h]
    simp

/-- **Every half line agrees with an `F`-preimage up to a null set.** -/
theorem measure_symmDiff_Iic (x : ℝ) :
    mu (symmDiff (Set.Iic x) ((cdf mu) ⁻¹' Set.Iic (cdf mu x))) = 0 := by
  have hpre : (cdf mu) ⁻¹' Set.Iic (cdf mu x) = {y : ℝ | cdf mu y ≤ cdf mu x} := rfl
  have hsub : Set.Iic x ⊆ {y : ℝ | cdf mu y ≤ cdf mu x} := fun y hy => (cdf mu).mono hy
  have hmeas : mu {y : ℝ | cdf mu y ≤ cdf mu x} = mu (Set.Iic x) := by
    rw [measure_cdf_le' mu (cdf_nonneg mu x) (cdf_le_one mu x), ofReal_cdf]
  rw [hpre]
  have hsymm : symmDiff (Set.Iic x) {y : ℝ | cdf mu y ≤ cdf mu x}
      = {y : ℝ | cdf mu y ≤ cdf mu x} \ Set.Iic x := by
    rw [Set.symmDiff_def]
    simp [Set.diff_eq_empty.2 hsub]
  rw [hsymm, measure_diff hsub measurableSet_Iic.nullMeasurableSet (measure_ne_top mu _),
    hmeas, tsub_self]

/-! ## 4. The measure-dense algebra of sets that are `F`-preimages mod null -/

/-- The measurable sets that agree with an `F`-preimage up to a `μ`-null set. -/
def cdfAlgebra : Set (Set ℝ) :=
  {s | MeasurableSet s ∧ ∃ B : Set ℝ, MeasurableSet B ∧
    mu (symmDiff s ((cdf mu) ⁻¹' B)) = 0}

omit [IsProbabilityMeasure mu] [NoAtoms mu] in
theorem isSetAlgebra_cdfAlgebra : IsSetAlgebra (cdfAlgebra mu) where
  empty_mem := ⟨MeasurableSet.empty, ∅, MeasurableSet.empty, by simp⟩
  compl_mem := by
    rintro s ⟨hs, B, hB, hsB⟩
    refine ⟨hs.compl, Bᶜ, hB.compl, ?_⟩
    have : (cdf mu) ⁻¹' Bᶜ = ((cdf mu) ⁻¹' B)ᶜ := rfl
    rw [this, compl_symmDiff_compl]
    exact hsB
  union_mem := by
    rintro s t ⟨hs, B, hB, hsB⟩ ⟨ht, C, hC, htC⟩
    refine ⟨hs.union ht, B ∪ C, hB.union hC, ?_⟩
    have hpre : (cdf mu) ⁻¹' (B ∪ C) = ((cdf mu) ⁻¹' B) ∪ ((cdf mu) ⁻¹' C) := rfl
    rw [hpre]
    refine le_antisymm ?_ (zero_le _)
    calc mu (symmDiff (s ∪ t) (((cdf mu) ⁻¹' B) ∪ ((cdf mu) ⁻¹' C)))
        ≤ mu (symmDiff s ((cdf mu) ⁻¹' B) ∪ symmDiff t ((cdf mu) ⁻¹' C)) :=
          measure_mono Set.union_symmDiff_union_subset
      _ ≤ mu (symmDiff s ((cdf mu) ⁻¹' B)) + mu (symmDiff t ((cdf mu) ⁻¹' C)) :=
          measure_union_le _ _
      _ = 0 := by rw [hsB, htC]; simp

theorem generateFrom_cdfAlgebra :
    (inferInstance : MeasurableSpace ℝ) = MeasurableSpace.generateFrom (cdfAlgebra mu) := by
  refine le_antisymm ?_ ?_
  · have hb : (inferInstance : MeasurableSpace ℝ)
        = MeasurableSpace.generateFrom (Set.range (Set.Iic : ℝ → Set ℝ)) := by
      rw [BorelSpace.measurable_eq (α := ℝ)]
      exact borel_eq_generateFrom_Iic ℝ
    rw [hb]
    refine MeasurableSpace.generateFrom_le ?_
    rintro s ⟨x, rfl⟩
    refine MeasurableSpace.measurableSet_generateFrom ?_
    exact ⟨measurableSet_Iic, Set.Iic (cdf mu x), measurableSet_Iic, measure_symmDiff_Iic mu x⟩
  · exact MeasurableSpace.generateFrom_le fun s hs => hs.1

theorem measureDense_cdfAlgebra : mu.MeasureDense (cdfAlgebra mu) :=
  Measure.MeasureDense.of_generateFrom_isSetAlgebra_finite mu (isSetAlgebra_cdfAlgebra mu)
    (generateFrom_cdfAlgebra mu)

/-! ## 5. Surjectivity -/

theorem indicatorConstLp_mem_cdfRange_of_mem {s : Set ℝ} (hs : s ∈ cdfAlgebra mu) (c : ℂ) :
    indicatorConstLp 2 hs.1 (measure_ne_top mu s) c ∈ cdfRange mu := by
  obtain ⟨hsm, B, hB, hsB⟩ := hs
  have hae : s =ᵐ[mu] (cdf mu) ⁻¹' B := measure_symmDiff_eq_zero_iff.1 hsB
  have hEq : indicatorConstLp 2 hsm (measure_ne_top mu s) c
      = indicatorConstLp 2 (hB.preimage (measurable_cdf mu)) (measure_ne_top mu _) c := by
    refine Lp.ext ?_
    filter_upwards [indicatorConstLp_coeFn (p := 2) (hs := hsm)
        (hμs := measure_ne_top mu s) (c := c),
      indicatorConstLp_coeFn (p := 2) (hs := hB.preimage (measurable_cdf mu))
        (hμs := measure_ne_top mu ((cdf mu) ⁻¹' B)) (c := c),
      indicator_ae_eq_of_ae_eq_set (f := fun _ : ℝ => c) hae] with x h1 h2 h3
    rw [h1, h2, h3]
  rw [hEq, ← cdfComp_indicatorConstLp mu hB c]
  exact ⟨_, rfl⟩

theorem indicatorConstLp_mem_cdfRange {s : Set ℝ} (hs : MeasurableSet s) (c : ℂ) :
    indicatorConstLp 2 hs (measure_ne_top mu s) c ∈ cdfRange mu := by
  haveI : Fact ((2 : ENNReal) ≠ ⊤) := ⟨by simp⟩
  have hsub := (measureDense_cdfAlgebra mu).indicatorConstLp_subset_closure 2 c
  have hmem : indicatorConstLp 2 hs (measure_ne_top mu s) c ∈
      closure {x | ∃ t, ∃ (ht : t ∈ cdfAlgebra mu) (hμt : mu t ≠ ⊤),
        indicatorConstLp 2 ((measureDense_cdfAlgebra mu).measurable t ht) hμt c = x} :=
    hsub ⟨s, hs, measure_ne_top mu s, rfl⟩
  have hcl : closure {x | ∃ t, ∃ (ht : t ∈ cdfAlgebra mu) (hμt : mu t ≠ ⊤),
      indicatorConstLp 2 ((measureDense_cdfAlgebra mu).measurable t ht) hμt c = x}
      ⊆ (cdfRange mu : Set (Lp ℂ 2 mu)) := by
    refine closure_minimal ?_ (isClosed_cdfRange mu)
    rintro - ⟨t, ht, hμt, rfl⟩
    exact indicatorConstLp_mem_cdfRange_of_mem mu ht c
  exact hcl hmem

/-- **Composition with the distribution function is onto.** -/
theorem cdfRange_eq_top : cdfRange mu = ⊤ := by
  refine Submodule.eq_top_iff'.2 ?_
  refine Lp.induction (p := 2) (by simp) (fun f => f ∈ cdfRange mu) ?_ ?_ ?_
  · intro c s hs hmus
    rw [Lp.simpleFunc.coe_indicatorConst]
    exact indicatorConstLp_mem_cdfRange mu hs c
  · intro f g hf hg _ hfm hgm
    exact Submodule.add_mem _ hfm hgm
  · exact isClosed_cdfRange mu

/-! ## 6. The unitary and the intertwining relation -/

/-- **The unitary of the diffuse model**: `L²` of the uniform measure on `[0, 1]` is
unitarily `L²(μ)`, through composition with the distribution function. -/
def cdfUnitary : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1)) ≃ₗᵢ[ℂ] Lp ℂ 2 mu :=
  LinearIsometryEquiv.ofSurjective (cdfComp mu) (by
    intro u
    have h : u ∈ cdfRange mu := by rw [cdfRange_eq_top]; trivial
    exact h)

theorem cdfUnitary_apply (f : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    cdfUnitary mu f = cdfComp mu f := rfl

theorem memLp_top_comp_cdf {g : ℝ → ℂ}
    (hg : MemLp g ⊤ (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    MemLp (fun x => g (cdf mu x)) ⊤ mu :=
  hg.comp_measurePreserving (measurePreserving_cdf mu)

/-- **The unitary intertwines the multiplication operators.** -/
theorem cdfUnitary_intertwines {g : ℝ → ℂ}
    (hg : MemLp g ⊤ (volume.restrict (Set.Icc (0 : ℝ) 1)))
    (u : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    cdfUnitary mu (multOp g hg u) =
      multOp (fun x => g (cdf mu x)) (memLp_top_comp_cdf mu hg) (cdfUnitary mu u) := by
  refine Lp.ext ?_
  have h1 := cdfComp_coeFn mu (multOp g hg u)
  have h2 := (measurePreserving_cdf mu).quasiMeasurePreserving.ae_eq_comp
    (multOp_coeFn (μ := volume.restrict (Set.Icc (0 : ℝ) 1)) g hg u)
  have h3 := multOp_coeFn (μ := mu) (fun x => g (cdf mu x)) (memLp_top_comp_cdf mu hg)
    (cdfComp mu u)
  have h4 := cdfComp_coeFn mu u
  filter_upwards [h1, h2, h3, h4] with x hx1 hx2 hx3 hx4
  simp only [Function.comp_apply] at hx2
  rw [cdfUnitary_apply, cdfUnitary_apply, hx1, hx2, hx3, hx4]

/-- **HEADLINE (the diffuse standard model, operator level).**  For an atomless Borel
probability measure `μ` on the line there is a unitary from `L²` of the uniform
measure on `[0, 1]` onto `L²(μ)` which carries multiplication by an essentially
bounded symbol `g` to multiplication by `g ∘ F`, where `F` is the distribution
function of `μ`.  So the multiplication algebra of *any* diffuse probability measure
on the line is unitarily the multiplication algebra of the unit interval — the
`L∞[0,1]` entry of the classification list. -/
theorem diffuse_multiplication_model_uniform :
    ∃ U : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1)) ≃ₗᵢ[ℂ] Lp ℂ 2 mu,
      ∀ (g : ℝ → ℂ) (hg : MemLp g ⊤ (volume.restrict (Set.Icc (0 : ℝ) 1)))
        (u : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))),
        (U (multOp g hg u) : ℝ → ℂ) =ᵐ[mu] fun x => g (cdf mu x) * (U u : ℝ → ℂ) x := by
  refine ⟨cdfUnitary mu, fun g hg u => ?_⟩
  rw [cdfUnitary_intertwines mu hg u]
  exact multOp_coeFn _ _ _

end BookProof.ChapterDiffuseUnitaryModel

end
