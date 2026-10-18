-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.norm_cAnnS_le
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterRieszFischer
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f : Ell2) : ‖cAnnS f‖ ≤ ‖f‖ := by

  rw [cAnnS, LinearIsometryEquiv.norm_map ContinuousLinearMap.adjoint (cCreS f)]
  exact norm_cCreS_le f
