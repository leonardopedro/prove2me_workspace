-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.kinOf_absorption
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQg3DCrossTermEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
open BookProof.Qg3DDensityEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.Qg3DCrossTermEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (S : Fin 4 → Fin 4 → Fin 84 → ℝ) (P : Fin 84 → ℝ) {y : ℝ}
    (hy : y ≠ 0) :
    kinOf (fun a b j => y * S a b j) (fun j => y * P j) (1 / y ^ 2) = kinOf S P 1 := by

  funext j k
  simp only [kinOf]
  have h1 : ∀ a b : Fin 4, qgEta a * qgEta b * (y * S a b j) * (y * S a b k)
      = y ^ 2 * (qgEta a * qgEta b * S a b j * S a b k) := fun a b => by ring
  simp only [h1, ← Finset.mul_sum]
  field_simp
