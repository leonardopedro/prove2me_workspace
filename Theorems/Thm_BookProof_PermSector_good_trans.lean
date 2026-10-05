-- Generated from ChapterPermutationSectorEsa.lean — theorem BookProof.PermSector.good_trans
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterTensorGraphCore
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.TensorCore
open BookProof.PermSector

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

theorem BookProof.PermSector.good_trans {n : ℕ}
    {uD vD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH vH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier}
    (hu : Good Hs D₂ A D n uD uH) (hv : Good Hs D₂ A D n vD vH) :
    Good Hs D₂ A D n (uD.trans vD) (uH.trans vH) where
  incl t := by sorry
