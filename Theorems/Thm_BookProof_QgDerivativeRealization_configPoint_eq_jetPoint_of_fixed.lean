-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.configPoint_eq_jetPoint_of_fixed
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge
open BookProof.QgDerivativeRealization



open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

theorem BookProof.QgDerivativeRealization.configPoint_eq_jetPoint_of_fixed (T : TetradConfig) (E : DerivFields)
    (hE : Fixed T E) (x : Fin 4 → ℝ) : configPoint T E x = jetPoint T x := by sorry
