-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.torsionPoly_antisymm
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
: RealCoeff (torsionPoly mu nu a) := by
  have h : starP (X (idxDE mu nu a) - X (idxDE nu mu a) : MvPolynomial (Fin 84) :=
   ℂ)
        = X (idxDE mu nu a) - X (idxDE nu mu a) := by
      rw [st
