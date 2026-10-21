-- Generated from ChapterQgPhysicalSectorIdentity.lean — solution of BookProof.QgPhysicalSectorIdentity.coupling_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Theorems.Thm_BookProof_QgPhysicalSectorIdentity_deg_pair_le_two
import Theorems.Thm_BookProof_QgPhysicalSectorIdentity_coupling_weighted_summable
import Theorems.Thm_BookProof_FockQuadratic_fockH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.QgPhysicalSectorIdentity




open BookProof.GaugeFixing
open BookProof.FockQuadratic
open BookProof.OperatorSeries
open BookProof.FarisLavine
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal

variable {F : BiDegree → Type} (S : DerivativeVariableFixingSystem F)
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i)
    (h : ι × ι → ℂ)
    (hsum : Summable fun k : ι × ι => ‖h k‖ * (ω k.1 + ω k.2 + 2)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((fockH hω (fun k : ι × ι => creIdx k.1) (fun k : ι × ι => annIdx k.2) h
          (fun p : ι × ι => deg_pair_le_two p.1 p.2)
          (coupling_weighted_summable h hsum)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) :=
  fockH_essentiallySelfAdjointOn_core hω (fun k : ι × ι => creIdx k.1)
      (fun k : ι × ι => annIdx k.2) h (fun p : ι × ι => deg_pair_le_two p.1 p.2)
      (coupling_weighted_summable h hsum)
