-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qgCCR_tetrad
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}

theorem BookProof.QuantumGravity3DGauge.qgCCR_tetrad (Φ : CoreRep 84 D) (mu a nu b : Fin 4) (x : D) :
    qgCoord Φ (idxE mu a) (qgMom Φ (idxE nu b) x) - qgMom Φ (idxE nu b) (qgCoord Φ (idxE mu a) x)
      = (if mu = nu ∧ a = b then Complex.I else 0) • x := by sorry
