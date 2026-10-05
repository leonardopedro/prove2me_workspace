-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.norm_cCreS_le
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f : Ell2) : ‖cCreS f‖ ≤ ‖f‖ := LinearMap.mkContinuous_norm_le _ (norm_nonneg f) _
