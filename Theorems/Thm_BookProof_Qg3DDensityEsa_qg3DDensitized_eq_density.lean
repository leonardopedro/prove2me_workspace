-- Generated from ChapterQg3DDensityEsa.lean — theorem BookProof.Qg3DDensityEsa.qg3DDensitized_eq_density
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
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
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.FullQuadratic
open BookProof.HermiteProductCore
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

theorem BookProof.Qg3DDensityEsa.qg3DDensitized_eq_density {y : ℝ} (hy : y ≠ 0) (St : Fin 4 → Fin 4 → Fin 84 → ℝ)
    (Pt : Fin 84 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    qg3DDensitizedHam y St Pt Qb
      = fqOp (kinOf (fun a b j => y * St a b j) (fun j => y * Pt j) (1 / y ^ 2))
          ((-(y ^ 2)) • Qb) (crossOf (fun a b j => y * St a b j) (fun j => y * Pt j)) 0 0 := by sorry
