-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.mkCore_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution {X : Vel → ℂ} (h : (Function.support X).Finite) (β : Vel) :
    (((mkCore h : lpFiniteModes Vel) : L2I Vel) : Vel → ℂ) β = X β := rfl
