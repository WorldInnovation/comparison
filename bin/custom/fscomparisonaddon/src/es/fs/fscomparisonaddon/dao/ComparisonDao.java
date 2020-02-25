package es.fs.fscomparisonaddon.dao;

import es.fs.fscomparisonaddon.model.ComparisonModel;

import java.util.List;
import java.util.Optional;

public interface ComparisonDao
{
    Optional<List<ComparisonModel>> getByUser(String user);

    List<ComparisonModel> getBySessionId(String sessionId);
}
