import Mathlib
import BookProof.ChapterLinftyMultiplication

/-!
# Splitting `L²(μ)` along a measurable set (plan GAP-2, the reassembly step)

The classification list of the abelian von Neumann algebras is a list of *direct
sums*: a summand measure splits into an atomic and a diffuse part
(`ChapterMeasureAtomicDiffuse`), and the two parts are modelled separately
(`ChapterAtomicDiagonalModel`, `ChapterDiffuseUnitaryModel`).  To reassemble the two
models into a statement about `L²(μ)` itself one needs the Hilbert-space counterpart
of the splitting of the measure, and that is what this module supplies:

* `restrictEmbed` — extension by zero, `L²(μ|A) →ₗᵢ[ℂ] L²(μ)`, `u ↦ 1_A · u`;
* `restrictEmbed_coeFn`, `restrictEmbed_restrictOf` — its a.e. formula, and the fact
  that the piece of `u` living on `A` is recovered by restricting and re-embedding;
* `inner_restrictEmbed_eq_zero` — embeddings along disjoint sets have orthogonal
  ranges;
* `restrictEmbed_add_restrictEmbed_compl` — `u = 1_A·u + 1_{Aᶜ}·u`;
* `orthogonalFamily_splitEmbed`, `isHilbertSum_splitEmbed` — **HEADLINE**: `L²(μ)` is
  the Hilbert sum of `L²(μ|A)` and `L²(μ|Aᶜ)`;
* `restrictEmbed_intertwines` — the embeddings intertwine the multiplication
  operators, so the splitting is a splitting of the multiplication *algebra* as well.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory

namespace BookProof.ChapterLpRestrictSplit

open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

/-! ## 1. Extension by zero -/

theorem indicator_ae_eq_of_restrict_ae_eq {A : Set α} (hA : MeasurableSet A) {f g : α → ℂ}
    (h : f =ᵐ[mu.restrict A] g) : A.indicator f =ᵐ[mu] A.indicator g := by
  filter_upwards [(ae_restrict_iff' hA).1 h] with x hx
  by_cases hxA : x ∈ A
  · simp [Set.indicator_of_mem hxA, hx hxA]
  · simp [Set.indicator_of_notMem hxA]

/-- Extending an `L²(μ|A)` function by zero lands in `L²(μ)`. -/
theorem memLp_indicator_of_restrict {A : Set α} (hA : MeasurableSet A)
    (u : Lp ℂ 2 (mu.restrict A)) : MemLp (A.indicator (u : α → ℂ)) 2 mu :=
  (memLp_indicator_iff_restrict hA).2 (Lp.memLp u)

/-- Extension by zero, as a linear map `L²(μ|A) → L²(μ)`. -/
def restrictEmbedLin {A : Set α} (hA : MeasurableSet A) :
    Lp ℂ 2 (mu.restrict A) →ₗ[ℂ] Lp ℂ 2 mu where
  toFun u := (memLp_indicator_of_restrict hA u).toLp _
  map_add' u v := by
    refine Lp.ext ?_
    filter_upwards [(memLp_indicator_of_restrict hA (u + v)).coeFn_toLp,
      Lp.coeFn_add ((memLp_indicator_of_restrict hA u).toLp _)
        ((memLp_indicator_of_restrict hA v).toLp _),
      (memLp_indicator_of_restrict hA u).coeFn_toLp,
      (memLp_indicator_of_restrict hA v).coeFn_toLp,
      indicator_ae_eq_of_restrict_ae_eq (mu := mu) hA (Lp.coeFn_add u v)] with x h1 h2 h3 h4 h5
    rw [h1, h2]
    simp only [Pi.add_apply]
    rw [h3, h4, h5]
    by_cases hxA : x ∈ A <;>
      simp [Set.indicator_of_mem, Set.indicator_of_notMem, hxA]
  map_smul' c u := by
    refine Lp.ext ?_
    filter_upwards [(memLp_indicator_of_restrict hA (c • u)).coeFn_toLp,
      Lp.coeFn_smul c ((memLp_indicator_of_restrict hA u).toLp _),
      (memLp_indicator_of_restrict hA u).coeFn_toLp,
      indicator_ae_eq_of_restrict_ae_eq (mu := mu) hA (Lp.coeFn_smul c u)] with x h1 h2 h3 h4
    simp only [RingHom.id_apply, h1, h2, h3, h4, Pi.smul_apply, smul_eq_mul]
    by_cases hxA : x ∈ A <;>
      simp [Set.indicator_of_mem, Set.indicator_of_notMem, hxA]

/-- **Extension by zero**, `L²(μ|A) →ₗᵢ[ℂ] L²(μ)`: it is an isometry because the
`L²(μ)` norm of `1_A · u` is computed by the restricted measure. -/
def restrictEmbed {A : Set α} (hA : MeasurableSet A) :
    Lp ℂ 2 (mu.restrict A) →ₗᵢ[ℂ] Lp ℂ 2 mu where
  toLinearMap := restrictEmbedLin hA
  norm_map' u := by
    change ‖(memLp_indicator_of_restrict hA u).toLp _‖ = ‖u‖
    rw [Lp.norm_toLp, Lp.norm_def, eLpNorm_indicator_eq_eLpNorm_restrict hA]

theorem restrictEmbed_coeFn {A : Set α} (hA : MeasurableSet A) (u : Lp ℂ 2 (mu.restrict A)) :
    (restrictEmbed hA u : α → ℂ) =ᵐ[mu] A.indicator (u : α → ℂ) :=
  (memLp_indicator_of_restrict hA u).coeFn_toLp

/-- The piece of `u` supported on `A`, as an element of `L²(μ|A)`. -/
def restrictProj (A : Set α) (u : Lp ℂ 2 mu) : Lp ℂ 2 (mu.restrict A) :=
  ((Lp.memLp u).restrict A).toLp _

theorem restrictEmbed_restrictProj_coeFn {A : Set α} (hA : MeasurableSet A) (u : Lp ℂ 2 mu) :
    (restrictEmbed hA (restrictProj A u) : α → ℂ) =ᵐ[mu] A.indicator (u : α → ℂ) := by
  refine (restrictEmbed_coeFn hA _).trans ?_
  exact indicator_ae_eq_of_restrict_ae_eq hA (((Lp.memLp u).restrict A).coeFn_toLp)

/-- **The splitting of a vector**: `u = 1_A·u + 1_{Aᶜ}·u`. -/
theorem restrictEmbed_add_restrictEmbed_compl {A : Set α} (hA : MeasurableSet A)
    (u : Lp ℂ 2 mu) :
    restrictEmbed hA (restrictProj A u) + restrictEmbed hA.compl (restrictProj Aᶜ u) = u := by
  refine Lp.ext ?_
  filter_upwards [Lp.coeFn_add (restrictEmbed hA (restrictProj A u))
      (restrictEmbed hA.compl (restrictProj Aᶜ u)),
    restrictEmbed_restrictProj_coeFn hA u,
    restrictEmbed_restrictProj_coeFn hA.compl u] with x h1 h2 h3
  rw [h1, Pi.add_apply, h2, h3]
  by_cases hxA : x ∈ A <;>
    simp [Set.indicator_of_mem, Set.indicator_of_notMem, hxA]

/-! ## 2. Orthogonality -/

theorem inner_restrictEmbed_eq_zero {A B : Set α} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hAB : Disjoint A B) (u : Lp ℂ 2 (mu.restrict A)) (v : Lp ℂ 2 (mu.restrict B)) :
    inner ℂ (restrictEmbed hA u) (restrictEmbed hB v) = 0 := by
  rw [L2.inner_def]
  have : ∀ᵐ x ∂mu, (inner ℂ ((restrictEmbed hA u : α → ℂ) x)
      ((restrictEmbed hB v : α → ℂ) x) : ℂ) = 0 := by
    filter_upwards [restrictEmbed_coeFn hA u, restrictEmbed_coeFn hB v] with x h1 h2
    rw [h1, h2]
    by_cases hxA : x ∈ A
    · have hxB : x ∉ B := Set.disjoint_left.1 hAB hxA
      simp [Set.indicator_of_notMem hxB]
    · simp [Set.indicator_of_notMem hxA]
  rw [integral_congr_ae this]
  simp

/-! ## 3. `L²(μ)` as the Hilbert sum of the two pieces -/

/-- The two-element family of pieces: `A` for `true`, `Aᶜ` for `false`. -/
def splitSet (A : Set α) (b : Bool) : Set α := cond b A Aᶜ

theorem measurableSet_splitSet {A : Set α} (hA : MeasurableSet A) (b : Bool) :
    MeasurableSet (splitSet A b) := by
  cases b <;> simp [splitSet, hA, hA.compl]

/-- The two isometric embeddings of the pieces into `L²(μ)`. -/
def splitEmbed {A : Set α} (hA : MeasurableSet A) (b : Bool) :
    Lp ℂ 2 (mu.restrict (splitSet A b)) →ₗᵢ[ℂ] Lp ℂ 2 mu :=
  restrictEmbed (measurableSet_splitSet hA b)

theorem orthogonalFamily_splitEmbed {A : Set α} (hA : MeasurableSet A) :
    OrthogonalFamily ℂ (fun b : Bool => Lp ℂ 2 (mu.restrict (splitSet A b)))
      (splitEmbed hA) := by
  intro i j hij u v
  have hdisj : Disjoint (splitSet A i) (splitSet A j) := by
    cases i <;> cases j <;> simp_all [splitSet, disjoint_compl_left, disjoint_compl_right]
  exact inner_restrictEmbed_eq_zero _ _ hdisj u v

/-- **HEADLINE (the Hilbert-space splitting).**  For a measurable set `A`, `L²(μ)` is
the Hilbert sum of `L²(μ|A)` and `L²(μ|Aᶜ)`, embedded by extension by zero. -/
theorem isHilbertSum_splitEmbed {A : Set α} (hA : MeasurableSet A) :
    IsHilbertSum ℂ (fun b : Bool => Lp ℂ 2 (mu.restrict (splitSet A b))) (splitEmbed hA) := by
  refine IsHilbertSum.mk (orthogonalFamily_splitEmbed hA) ?_
  refine le_trans ?_ (Submodule.le_topologicalClosure _)
  rintro u -
  rw [← restrictEmbed_add_restrictEmbed_compl (mu := mu) hA u]
  refine Submodule.add_mem _ ?_ ?_
  · exact le_iSup (fun b : Bool => (splitEmbed hA b).range) true ⟨restrictProj A u, rfl⟩
  · exact le_iSup (fun b : Bool => (splitEmbed hA b).range) false ⟨restrictProj Aᶜ u, rfl⟩

/-! ## 4. The splitting is a splitting of the multiplication algebra -/

/-- **The embeddings intertwine the multiplication operators.** -/
theorem restrictEmbed_intertwines {A : Set α} (hA : MeasurableSet A) {g : α → ℂ}
    (hg : MemLp g ⊤ mu) (u : Lp ℂ 2 (mu.restrict A)) :
    restrictEmbed hA (multOp g (hg.restrict A) u) = multOp g hg (restrictEmbed hA u) := by
  refine Lp.ext ?_
  filter_upwards [restrictEmbed_coeFn hA (multOp g (hg.restrict A) u),
    indicator_ae_eq_of_restrict_ae_eq (mu := mu) hA
      (multOp_coeFn (μ := mu.restrict A) g (hg.restrict A) u),
    multOp_coeFn (μ := mu) g hg (restrictEmbed hA u),
    restrictEmbed_coeFn hA u] with x h1 h2 h3 h4
  rw [h1, h2, h3, h4]
  by_cases hxA : x ∈ A <;>
    simp [Set.indicator_of_mem, Set.indicator_of_notMem, hxA]

end BookProof.ChapterLpRestrictSplit

end
