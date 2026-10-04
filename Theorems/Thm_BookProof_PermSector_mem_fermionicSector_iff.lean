-- Generated from ChapterPermutationSectorEsa.lean — theorem BookProof.PermSector.mem_fermionicSector_iff
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterA4
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.TensorCore
open BookProof.ChapterWignerLittleGroup
open BookProof.PermSector

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

theorem BookProof.PermSector.mem_fermionicSector_iff (n : ℕ) {x : (Hs.pow n).carrier} :
    x ∈ sector (fermionicProj Hs n)
      ↔ ∀ σ : Equiv.Perm (Fin n),
          permOp Hs n σ x = ((Equiv.Perm.sign σ : ℤ) : ℂ) • x := by sorry
