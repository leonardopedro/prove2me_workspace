-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.total_dom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.NavierStokesFlow.FockLagrangian

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : DominatedOn μ S.scale S.total := by

  have hP : DominatedOn μ S.scale (fun x => (1 / 2 : ℝ) * ∑ i : Fin 3, (S.P i x) ^ 2 ) := by
    refine DominatedOn.const_mul _ ?_
    refine DominatedOn.sum Finset.univ fun i _ => ?_
    have := (S.P_dom i).mul (S.P_dom i)
    exact this.of_abs_le (Filter.Eventually.of_forall fun x => by rw [pow_two])
  have hQ : DominatedOn μ S.scale (fun x => S.nu * ∑ i : Fin 3, (S.Q i x) ^ 2) := by
    refine DominatedOn.const_mul _ ?_
    refine DominatedOn.sum Finset.univ fun i _ => ?_
    have := (S.Q_dom i).mul (S.Q_dom i)
    exact this.of_abs_le (Filter.Eventually.of_forall fun x => by rw [pow_two])
  have hD : DominatedOn μ S.scale (fun x => ∑ i : Fin 3, S.force i * S.Dr i x) :=
    DominatedOn.sum Finset.univ fun i _ => DominatedOn.const_mul _ (S.Dr_dom i)
  exact ((hP.add hQ).add hD).add S.c_dom
