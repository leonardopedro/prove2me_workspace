-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.good_trans
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ}
    {uD vD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH vH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier}
    (hu : Good Hs D₂ A D n uD uH) (hv : Good Hs D₂ A D n vD vH) :
    Good Hs D₂ A D n (uD.trans vD) (uH.trans vH) where
  incl t :=
  where
    incl t := by
      change inclPow Hs D₂ n (vD (uD t)) = vH (uH (inclPow Hs D₂ n t))
      rw [hv.incl, hu.incl]
    der t := by
      change derPow Hs D₂ A n (vD (uD t)) = vH (uH (derPow Hs D₂ A n t))
      rw [hv.der, hu.der]
    core t ht := hv.core _ (hu.core t ht)
