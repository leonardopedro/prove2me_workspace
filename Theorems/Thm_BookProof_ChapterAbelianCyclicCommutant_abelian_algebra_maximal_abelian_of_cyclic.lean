-- Generated from ChapterAbelianCyclicCommutant.lean — theorem BookProof.ChapterAbelianCyclicCommutant.abelian_algebra_maximal_abelian_of_cyclic
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterAbelianCyclicModel
import Mathlib
import Definitions.Def_ChapterAbelianCyclicCommutant
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

variable {A : Type*} [CommCStarAlgebra A]

theorem BookProof.ChapterAbelianCyclicCommutant.abelian_algebra_maximal_abelian_of_cyclic (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)
    (hcyc : DenseRange fun a : A => rho a xi) :
    (Set.range fun a : A => rho a).centralizer.centralizer
        = (Set.range fun a : A => rho a).centralizer ∧
      ∀ S R : H →L[ℂ] H, S ∈ (Set.range fun a : A => rho a).centralizer →
        R ∈ (Set.range fun a : A => rho a).centralizer → S * R = R * S := by sorry
