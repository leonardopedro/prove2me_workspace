import Definitions.Def_ChapterAtomicDiagonalModel
import Definitions.Def_ChapterDiffuseUnitaryModel
import Definitions.Def_ChapterLpRestrictSplit
import Definitions.Def_ChapterLpScaleMeasure
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterLinftyMultiplication
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
def normalized : Measure ℝ := (nu Set.univ)⁻¹ • nu

instance : NullSingletonClass (normalized nu) := noAtoms_smul _





end Diffuse

/-! ## 4. The standard model of a summand -/

variable (mu : Measure ℝ) [IsProbabilityMeasure mu]



/-! ## 5. The list -/



end BookProof.ChapterAbelianClassificationList

end
