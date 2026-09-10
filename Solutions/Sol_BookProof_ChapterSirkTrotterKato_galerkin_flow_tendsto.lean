-- Generated from ChapterSirkTrotterKatoGalerkin.lean — solution of BookProof.ChapterSirkTrotterKato.galerkin_flow_tendsto
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_flow_tendsto_of_strong_tendsto
open BookProof.ChapterSirkTrotterKato









noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]










open BookProof.HermiteGalerkin

set_option maxHeartbeats 1000000 in
theorem solution {A : H →L[ℂ] H} (hA : IsSelfAdjoint A)
    (b : HilbertBasis ℕ ℂ H) (v : H) (t : ℝ) :
    Tendsto (fun m => (ofBounded (galerkinCompression A b m)
      (isSelfAdjoint_galerkinCompression hA b m)).stoneU t v) atTop
      (𝓝 ((ofBounded A hA).stoneU t v)) :=
  flow_tendsto_of_strong_tendsto (fun m => isSelfAdjoint_galerkinCompression hA b m) hA
      (galerkinCompression_tendsto A b) v t
