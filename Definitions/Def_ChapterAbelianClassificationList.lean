import Definitions.Def_ChapterAtomicDiagonalModel
import Definitions.Def_ChapterDiffuseUnitaryModel
import Definitions.Def_ChapterLpRestrictSplit
import Definitions.Def_ChapterLpScaleMeasure
import Mathlib


/-!
# Reassembling the classification list (plan GAP-2, the final step)

The previous waves produced all the pieces of the manuscript's abelian
classification list and left exactly one step open: *reassembly* — rewriting a
classified summand as **one** of the five standard models.  This module performs it
for a Borel probability measure on the line.

Write `S` for the (countable) set of atoms of `μ`.  Then

* `L²(μ)` is the Hilbert sum of `L²(μ|S)` and `L²(μ|Sᶜ)`, and the two embeddings
  intertwine the multiplication operators
  (`ChapterLpRestrictSplit.isHilbertSum_splitEmbed`, `restrictEmbed_intertwines`);
* the first piece is *purely atomic*, so multiplication is **diagonal** in the
  orthonormal basis of normalised point masses (`ChapterAtomicDiagonalModel`);
* the second piece is *diffuse*; after normalising its mass
  (`ChapterLpScaleMeasure`) its distribution function gives a unitary with `L²[0,1]`
  carrying multiplication by `g` to multiplication by `g ∘ F`
  (`ChapterDiffuseUnitaryModel`).

Assembling these gives the headline `abelian_summand_standard_model`, and the
case distinction on `μ(S)`, `μ(Sᶜ)` and the cardinality of `S` gives the list itself,
`vonNeumann_abelian_classification_list`: every summand is `Iₙ`, `ℓ∞(ℕ)`, `L∞[0,1]`,
`L∞[0,1] ⊕ Iₙ` or `L∞[0,1] ⊕ ℓ∞(ℕ)`.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory ProbabilityTheory

namespace BookProof.ChapterAbelianClassificationList

open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterDiffuseUnitaryModel BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpRestrictSplit BookProof.ChapterLpScaleMeasure

/-! ## 1. The atomic piece is purely atomic -/

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]





/-! ## 2. Scaling preserves diffuseness -/

omit [MeasurableSingletonClass α] in
theorem noAtoms_smul {nu : Measure α} [NullSingletonClass nu] (c : ENNReal) : NullSingletonClass (c • nu) := by
  constructor
  intro x
  simp [Measure.smul_apply]

/-! ## 3. The diffuse piece is a copy of the unit interval -/

section Diffuse

variable (nu : Measure ℝ) [IsFiniteMeasure nu] [NullSingletonClass nu]

/-- The normalised diffuse measure: an atomless probability measure on the line. -/
def normalized : Measureimport BookProof.ChapterAtomicDiagonalModel

/-!
# Reassembling the classification list (plan GAP-2, the final step)

The previous waves produced all the pieces of the manuscript's abelian
classification list and left exactly one step open: *reassembly* — rewriting a
classified summand as **one** of the five standard models.  This module performs it
for a Borel probability measure on the line.

Write `S` for the (countable) set of atoms of `μ`.  Then

* `L²(μ)` is the Hilbert sum of `L²(μ|S)` and `L²(μ|Sᶜ)`, and the two embeddings
  intertwine the multiplication operators
  (`ChapterLpRestrictSplit.isHilbertSum_splitEmbed`, `restrictEmbed_intertwines`);
* the first piece is *purely atomic*, so multiplication is **diagonal** in the
  orthonormal basis of normalised point masses (`ChapterAtomicDiagonalModel`);
* the second piece is *diffuse*; after normalising its mass
  (`ChapterLpScaleMeasure`) its distribution function gives a unitary with `L²[0,1]`
  carrying multiplication by `g` to multiplication by `g ∘ F`
  (`ChapterDiffuseUnitaryModel`).

Assembling these gives the headline `abelian_summand_standard_model`, and the
case distinction on `μ(S)`, `μ(Sᶜ)` and the cardinality of `S` gives the list itself,
`vonNeumann_abelian_classification_list`: every summand is `Iₙ`, `ℓ∞(ℕ)`, `L∞[0,1]`,
`L∞[0,1] ⊕ Iₙ` or `L∞[0,1] ⊕ ℓ∞(ℕ)`.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory ProbabilityTheory

namespace BookProof.ChapterAbelianClassificationList

open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterDiffuseUnitaryModel BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpRestrictSplit BookProof.ChapterLpScaleMeasure

/-! ## 1. The atomic piece is purely atomic -/

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]

theorem atomSet_restrict_atomSet (mu : Measure α) [IsFiniteMeasure mu] :
    atomSet (mu.restrict (atomSet mu)) = atomSet mu := by
  ext x
  simp only [mem_atomSet_iff, Measure.restrict_apply (measurableSet_singleton x)]
  by_cases hx : x ∈ atomSet mu
  · have hxx : ({x} : Set α) ∩ atomSet mu = {x} :=
      Set.inter_eq_left.2 (Set.singleton_subset_iff.2 hx)
    simp [hxx, hx] at *
  · have h0 : mu {x} = 0 := by simpa [atomSet] using hx
    have hzero : mu ({x} ∩ atomSet mu) = 0 :=
      measure_mono_null Set.inter_subset_left h0
    rw [hzero]
    simp [h0]

theorem restrict_atomSet_pure (mu : Measure α) [IsFiniteMeasure mu] :
    (mu.restrict (atomSet mu)) (atomSet (mu.restrict (atomSet mu)))ᶜ = 0 := by
  rw [atomSet_restrict_atomSet mu,
    Measure.restrict_apply (measurableSet_atomSet mu).compl]
  simp

/-! ## 2. Scaling preserves diffuseness -/

omit [MeasurableSingletonClass α] in
theorem noAtoms_smul {nu : Measure α} [NullSingletonClass nu] (c : ENNReal) : NullSingletonClass (c • nu) := by
  constructor
  intro x
  simp [Measure.smul_apply]

/-! ## 3. The diffuse piece is a copy of the unit interval -/

section Diffuse

variable (nu : Measure ℝ) [IsFiniteMeasure nu] [NullSingletonClass nu]

/-- The normalised diffuse measure: an atomless probability measure on the line. -/
def normalized : Measure ℝ := (nu Set.univ)⁻¹ • nu

instance : NullSingle (   _ =ᵐ[nu] fun x => g (cdf (normalized nu) x) *
          ((scaleUnitary hc0 hctop (cdfUnitary (normalized nu) u)agonal _ (restrict_atomSex⟩ := Set.nonempty_iff_ne_empty.2 hne
      exact hx (measure_mono_null (Set.singleton_subset_iff.2 hx) hat)
    · rcases Set.finite_or_infinite (atomSet mu) with hfin | hinf
      · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨hat, hdiff, hfin⟩)))
      · exact Or.inr (Or.inr (Or.inr (Or.inr ⟨hat, hdiff, hinf, hequiv hinf⟩)))

end BookProof.ChapterAbelianClassificationList

end
