-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.eval_torsionPoly_jetPoint
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

theorem BookProof.QgDerivativeRealization.eval_torsionPoly_jetPoint (T : TetradConfig) (x : Fin 4 → ℝ) (mu nu a : Fin 4) :
    MvPolynomial.eval (jetPoint T x) (torsionPoly mu nu a)
      = ((MvPolynomial.eval x (pderiv mu (T.comp nu a)) : ℝ) : ℂ)
        - ((MvPolynomial.eval x (pderiv nu (T.comp mu a)) : ℝ) : ℂ) := by sorry
