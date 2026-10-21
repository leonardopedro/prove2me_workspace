-- Generated from ChapterAbelianCyclicCommutant.lean — solution of BookProof.ChapterAbelianCyclicCommutant.abelian_algebra_maximal_abelian_of_cyclic
import Mathlib
import Definitions.Def_ChapterAbelianCyclicCommutant
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_centralizer_repSet
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_bicommutant_repSet
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_commutant_repSet_isCommutative
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_repSet_gelfandRep
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_denseRange_repVec_gelfandRep
open BookProof.ChapterAbelianCyclicCommutant



noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralCommutant
open BookProof.ChapterAbelianCyclicModel


variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H) (hcyc : DenseRange (repVec pi xi))

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H) (hcyc : DenseRange (repVec pi xi))
variable {A : Type*} [CommCStarAlgebra A]

set_option maxHeartbeats 1000000 in
theorem solution (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)
    (hcyc : DenseRange fun a : A => rho a xi) :
    (Set.range fun a : A => rho a).centralizer.centralizer
        = (Set.range fun a : A => rho a).centralizer ∧
      ∀ S R : H →L[ℂ] H, S ∈ (Set.range fun a : A => rho a).centralizer →
        R ∈ (Set.range fun a : A => rho a).centralizer → S * R = R * S := by

  have hcyc' := denseRange_repVec_gelfandRep hcyc
  have hset := repSet_gelfandRep rho
  constructor
  · rw [← hset, bicommutant_repSet (gelfandRep rho) xi hcyc',
      centralizer_repSet (gelfandRep rho) xi hcyc']
  · intro S R hS hR
    rw [← hset] at hS hR
    exact commutant_repSet_isCommutative (gelfandRep rho) xi hcyc' hS hR
